import re

class BaseLogAnalyzer:
    def __init__(self, lines):
        self.lines = lines
        self.did_tests_fail = False
        self.num_tests_failed = 0
        self.num_tests_run = 0
        self.num_tests_passed = 0
        self.num_tests_skipped = 0
        self.test_duration = 0.0
        self.tests_failed = []
        self.tests_skipped = []
        self.framework = None

    def analyze(self):
        raise NotImplementedError("Subclasses should implement this method")
    
    def is_applicable(self):
        """Our Analyzers can override this and use to check logs searching for something unique to them 
        and determine if the logfile applies to them"""
        return False

        
class RustLogAnalyzer(BaseLogAnalyzer):
    def __init__(self, lines):
        super().__init__(lines)
        self.framework = "cargo"
    
    def is_applicable(self):
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        for line in self.lines:
            # jest_tests = re.search(r'Tests:\s+(\d+ failed, )?(\d+ skipped, )?(\d+ passed, )?(\d+ total)', line)
            # jest_time = re.search(r'Time:\s+(\d+\.?\d*)\s?s', line)
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            rust_tests = re.search(r'test result:\s+(ok|FAILED). (\d+) passed; (\d+) failed; (\d+) ignored; (\d+) measured; (\d+) filtered out; finished in (\d+\.?\d*)\s?s', line)
            if rust_tests:
                return True
        return False
            
    def get_int_from_match(self, match):
        return int(re.sub(r'\D', '', match)) if match else 0
    
    def analyze(self):
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        for line in self.lines:
            # jest_tests = re.search(r'Tests:\s+(\d+ failed, )?(\d+ skipped, )?(\d+ passed, )?(\d+ total)', line)
            # jest_time = re.search(r'Time:\s+(\d+\.?\d*)\s?s', line)
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            rust_tests = re.search(r'test result:\s+(ok|FAILED). (\d+) passed; (\d+) failed; (\d+) ignored; (\d+) measured; (\d+) filtered out; finished in (\d+\.?\d*)\s?s', line)
            failed_test_pattern = re.compile(r'^\s*test\s+(?P<name>.+)\s+\.\.\.\s+FAILED\s*$', re.IGNORECASE)
            
            failed_test = failed_test_pattern.match(line)
            if failed_test:
                name = failed_test.group("name").strip()
                self.tests_failed.append(name)
            
            ignored_test_pattern = re.compile(r'^\s*test\s+(?P<name>.+)\s+\.\.\.\s+ignored\s*$', re.IGNORECASE)
            
            ignored_test = ignored_test_pattern.match(line)
            if ignored_test:
                name = ignored_test.group("name").strip()
                self.tests_skipped.append(name)
            
            if rust_tests:
                rust_passed = rust_tests.group(2)

                self.num_tests_passed += int(rust_passed)
                
                rust_failed = rust_tests.group(3)
                self.num_tests_failed += int(rust_failed)
                
                rust_skipped = int(rust_tests.group(4)) + int(rust_tests.group(6))
                self.num_tests_skipped += int(rust_skipped)
                
                self.num_tests_run = self.num_tests_passed + self.num_tests_failed + self.num_tests_skipped

                self.test_duration += float(rust_tests.group(7))
                
        
        return {
            "framework": self.framework,
            "num_tests_run": self.num_tests_run,
            "num_tests_failed": self.num_tests_failed,
            "num_tests_passed": self.num_tests_passed,
            "num_tests_skipped": self.num_tests_skipped,
            "tests_failed": self.tests_failed,
            "tests_skipped": self.tests_skipped,
            "test_duration": self.test_duration
        }
        
        
class NextTestLogAnalyzer(BaseLogAnalyzer):
    def __init__(self, lines):
        super().__init__(lines)
        self.framework = "nexttest"
        
    def is_applicable(self):
        NEXTTEST_SUMMARY_RE = re.compile(
            r"""^\s*Summary\s*\[\s*(?P<secs>\d+(?:\.\d+)?)s\]\s*
                (?P<run>\d+)\s+tests\s+run:\s*
                (?P<passed>\d+)\s+passed
                (?:,\s*(?P<failed>\d+)\s+failed)?
                (?:,\s*(?P<skipped>\d+)\s+skipped)?
                \s*$""",
            re.VERBOSE,
        )
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        for line in self.lines:
            # jest_tests = re.search(r'Tests:\s+(\d+ failed, )?(\d+ skipped, )?(\d+ passed, )?(\d+ total)', line)
            # jest_time = re.search(r'Time:\s+(\d+\.?\d*)\s?s', line)
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            rust_tests = NEXTTEST_SUMMARY_RE.match(line)
            if rust_tests:
                return True
        return False
    
    def analyze(self):
        NEXTTEST_SUMMARY_RE = re.compile(
            r"""^\s*Summary\s*\[\s*(?P<secs>\d+(?:\.\d+)?)s\]\s*
                (?P<run>\d+)\s+tests\s+run:\s*
                (?P<passed>\d+)\s+passed
                (?:,\s*(?P<failed>\d+)\s+failed)?
                (?:,\s*(?P<skipped>\d+)\s+skipped)?
                \s*$""",
            re.VERBOSE,
        )
        
        NEXTEST_FAIL_RE = re.compile(
            r'FAIL\s*\[\s*(?P<secs>\d+(?:\.\d+)?)s\s*\]\s*'
            r'\(\s*(?P<idx>\d+)\s*/\s*(?P<total>\d+)\s*\)\s*'
            r'(?P<name>.+)$'
        )
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        for line in self.lines:
            # jest_tests = re.search(r'Tests:\s+(\d+ failed, )?(\d+ skipped, )?(\d+ passed, )?(\d+ total)', line)
            # jest_time = re.search(r'Time:\s+(\d+\.?\d*)\s?s', line)
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            rust_tests = NEXTTEST_SUMMARY_RE.match(line)
            if rust_tests:
                failed = int(rust_tests.group("failed")) if rust_tests.group("failed") is not None else 0
                skipped = int(rust_tests.group("skipped")) if rust_tests.group("failed") is not None else 0
                passed = int(rust_tests.group("passed"))
                self.num_tests_failed += failed
                self.num_tests_skipped += skipped
                self.num_tests_passed += passed
                self.num_tests_run += failed + passed + skipped
                self.test_duration = float(rust_tests.group("secs"))
                
            rust_test_fail = NEXTEST_FAIL_RE.search(line)
            if rust_test_fail:
                self.tests_failed.append(rust_test_fail.group("name"))
                
        return {
            "framework": self.framework,
            "num_tests_run": self.num_tests_run,
            "num_tests_failed": self.num_tests_failed,
            "num_tests_passed": self.num_tests_passed,
            "num_tests_skipped": self.num_tests_skipped,
            "tests_failed": self.tests_failed,
            "tests_skipped": self.tests_skipped,
            "test_duration": self.test_duration
        }
                
# def detect_analyzer(log_lines):
#     analyzers = [
#         RustLogAnalyzer,
#         NextTestLogAnalyzer
#     ]
    
#     applicable = []
#     for AnalyzerClass in analyzers:
#         analyzer = AnalyzerClass(log_lines)
#         if analyzer.is_applicable():
#             applicable.append(analyzer)
    
#     if not applicable:
#         return None
    
#     # For now, we'll just return the first match. Since there can be only one unique ?
#     return applicable
        
# def read_log_file(file_path):
#     with open(file_path, 'r', encoding='utf-8') as file:
#         return file.readlines()

# log_lines = read_log_file("log_.txt")
    
# analyzer = detect_analyzer(log_lines)
# results_list = [] 
# if analyzer:
#     for a in analyzer:
#         results = a.analyze()
#         results_list.append(results)
#     print(results_list)
# else:
#     print("No applicable analyzer found for this log.")
    
