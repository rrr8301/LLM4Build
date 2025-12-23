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

        
class GoLogAnalyzer(BaseLogAnalyzer):
    def __init__(self, lines):
        super().__init__(lines)
        self.framework = "GoDefault"
        
    def is_applicable(self):
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        pattern = re.compile(r'^\s*(ok|FAIL)\s+(\S+)\s+(\d+(?:\.\d+)?)s', re.IGNORECASE)
        for raw in self.lines:
            line = ansi_escape.sub('', raw)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            if (pattern.search(line)):
                return True
        return False
    
    
    def get_int_from_match(self, match):
        return int(re.sub(r'\D', '', match)) if match else 0
    
    def count_go_tests(self, pattern):
        # 1. Collect all test names from "=== RUN" lines
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        names = []
        for line in self.lines:
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            m = pattern.search(line)
            if m:
                names.append(m.group("name"))

        names_set = set(names)

        # 2. Count only those names that are NOT parents of another test
        leaf_names = []
        for name in names_set:
            is_parent = any(
                other != name and other.startswith(name + "/")
                for other in names_set
            )
            if not is_parent:
                leaf_names.append(name)

        return len(leaf_names)
    
    def analyze(self):
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        go_run_tests = re.compile(r'^=== RUN\s+(?P<name>\S+)', re.IGNORECASE)
        go_pass_tests = re.compile(r'^\s*---\s+PASS:\s+(?P<name>\S+)\s+\((?P<secs>\d+(?:\.\d+)?)s\)', re.IGNORECASE)
        go_fail_tests = re.compile(r'^\s*FAIL\s+(?P<name>\S+)\s+(.*)', re.IGNORECASE)
        # ok  	github.com/IBM/fp-go/v2/tuple	1.037s	coverage: 81.4% of statements
        go_test_duration_pattern = re.compile(r'^\s*(ok|FAIL)\s+(\S+)\s+(\d+(?:\.\d+)?)s', re.IGNORECASE)
        self.num_tests_run += self.count_go_tests(go_run_tests)
        self.num_tests_passed += self.count_go_tests(go_pass_tests)
        for line in self.lines:
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            
            m = go_test_duration_pattern.match(line)
            if m:
                duration = float(m.group(3))
                self.test_duration += duration
                
            failed_tests_line = go_fail_tests.search(line)
            
            if failed_tests_line:
                self.tests_failed.append(failed_tests_line.group('name'))
            
        return {
            "framework": self.framework,
            "num_tests_run": self.num_tests_run,
            "num_tests_failed": len(self.tests_failed),
            "num_tests_passed": self.num_tests_passed,
            "num_tests_skipped": self.num_tests_skipped,
            "tests_failed": self.tests_failed,
            "tests_skipped": self.tests_skipped,
            "test_duration": self.test_duration
        }
        
class GoRaceLogAnalyzer(BaseLogAnalyzer):
    def __init__(self, lines):
        super().__init__(lines)
        self.framework = "GoRace"
        
    def is_applicable(self):
        pattern = re.compile(
            r'^DONE\s+(?P<tests>\d+)\s+tests'
            r'(?:,\s+(?P<skipped>\d+)\s+skipped)?'
            r'(?:,\s+(?P<failed>\d+)\s+failures?)?'
            r'\s+in\s+(?P<secs>\d+(?:\.\d+)?)s$', re.IGNORECASE
        )
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        for raw in self.lines:
            line = ansi_escape.sub('', raw)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            if (pattern.search(line)):
                return True
        return False
        
    
    def get_int_from_match(self, match):
        return int(re.sub(r'\D', '', match)) if match else 0
    
    def analyze(self):
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        go_test_pattern = re.compile(
            r'^DONE\s+(?P<tests>\d+)\s+tests'
            r'(?:,\s+(?P<skipped>\d+)\s+skipped)?'
            r'(?:,\s+(?P<failed>\d+)\s+failures?)?'
            r'\s+in\s+(?P<secs>\d+(?:\.\d+)?)s$', re.IGNORECASE
        )
        
        go_skip_tests = re.compile(r'^===\s+SKIP:\s+(?P<pkg>\S+)\s+(?P<test>\S+)\s+\((?P<secs>\d+(?:\.\d+)?)s\)$', re.IGNORECASE)
        go_fail_tests = re.compile(r'^===\s+FAIL:\s+(?P<pkg>\S+)\s+(?P<test>\S+)\s+\((?P<secs>\d+(?:\.\d+)?)s\)$', re.IGNORECASE)
        
        for line in self.lines:
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            go_test_line = go_test_pattern.search(line)
            if go_test_line:
                self.num_tests_run = int(go_test_line.group('tests'))
                if go_test_line.group('skipped'):
                    self.num_tests_skipped = int(go_test_line.group('skipped'))
                if go_test_line.group('failed'):
                    self.num_tests_failed = int(go_test_line.group('failed'))
                if go_test_line.group('secs'):
                    self.test_duration = float(go_test_line.group('secs'))
                    
            go_failed_line = go_fail_tests.search(line)
            if go_failed_line:
                self.tests_failed.append({
                    "file": go_failed_line.group("pkg"),
                    "test": go_failed_line.group("test")
                })
            go_skip_line = go_skip_tests.search(line)
            if go_skip_line:
                self.tests_skipped.append({
                    "file": go_skip_line.group("pkg"),
                    "test": go_skip_line.group("test")
                })
        
        self.num_tests_passed = self.num_tests_run - (self.num_tests_failed + self.num_tests_skipped)
                
        return {
            "framework": self.framework,
            "num_tests_run": self.num_tests_run,
            "num_tests_failed": self.num_tests_failed ,
            "num_tests_passed": self.num_tests_passed,
            "num_tests_skipped": self.num_tests_skipped,
            "tests_failed": self.tests_failed,
            "tests_skipped": self.tests_skipped,
            "test_duration": self.test_duration
        }    
    
        
# def detect_analyzer(log_lines):
#     analyzers = [
#         GoLogAnalyzer,
#         GoRaceLogAnalyzer
#     ]
    
#     applicable = []
#     for AnalyzerClass in analyzers:
#         analyzer = AnalyzerClass(log_lines)
#         if analyzer.is_applicable():
#             applicable.append(analyzer)
    
#     if not applicable:
#         return None
    
#     # For now, we'll just return the first match. Since there can be only one unique ?
#     return applicable[0]
        
# def read_log_file(file_path):
#     with open(file_path, 'r', encoding='utf-8') as file:
#         return file.readlines()

# log_lines = read_log_file("akvorado-56521597784.log")
    
# analyzer = detect_analyzer(log_lines)
    
# if analyzer:
#     results = analyzer.analyze()
#     print(results)
# else:
#     print("No applicable analyzer found for this log.")  