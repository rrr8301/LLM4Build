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
    
class PytestLogAnalyzer(BaseLogAnalyzer):
    def __init__(self, lines):
        super().__init__(lines)
        self.framework = "pytest"
        self.num_tests_xfailed = 0
        self.tests_xfailed = []
        self.num_tests_xpassed = 0
        self.tests_xpassed = []
        self.num_tests_deselected = 0
        self.short_summary = False
        
    def is_applicable(self):
        return any(re.search(r'\bpytest\b', line, re.IGNORECASE) for line in self.lines)
    
    def get_int_from_match(self, match):
        return int(re.sub(r'\D', '', match)) if match else 0
    
    def analyze(self):
        pytest_pattern = re.compile(
            r"""=+\s*                                  # leading ===
                (?:(?P<failed>\d+)\s+failed,?\s*)?     # 2 failed,
                (?:(?P<passed>\d+)\s+passed,?\s*)?     # 12891 passed,
                (?:(?P<skipped>\d+)\s+skipped,?\s*)?   # 677 skipped,
                (?:(?P<deselected>\d+)\s+deselected,?\s*)? # 30 deselected,
                (?:(?P<xfail>\d+)\s+xfailed,?\s*)?     # 331 xfailed,
                (?:(?P<xpass>\d+)\s+xpassed,?\s*)?     # 3 xpassed,
                (?:(?P<warnings>\d+)\s+warning(?:s)?,?\s*)? # 1 warning
                in\s+(?P<secs>[\d.]+)\s*(?:s|seconds)  # in 1159.87s
                (?:\s*\([\d:]+\))?                     # optional (0:19:19)
                \s*=+                                  # trailing ===
            """, re.IGNORECASE | re.VERBOSE,
        )
        short_summary_pattern = re.compile(r"=+\s*short test summary info\s*=+", re.IGNORECASE)
        failed_test_pattern = re.compile(r"^(FAILED|ERROR)\s+(.*)::(.*)\s+-\s+(.*)")
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        for line in self.lines:
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            
            short_summary = short_summary_pattern.search(line)
            if short_summary:
                self.short_summary = True
                continue
            
            if self.short_summary == True:
                failed_test = failed_test_pattern.search(line)
                if failed_test:
                    self.tests_failed.append(
                        {
                            "file": failed_test.group(2),
                            "function": failed_test.group(3)
                        }
                    )
            
            pytest_pattern_= pytest_pattern.search(line)
            
            if pytest_pattern_:
                short_summary = False
                failed_tests_num = pytest_pattern_.group("failed")
                if failed_tests_num:
                    self.num_tests_failed += int(failed_tests_num)
                    self.num_tests_run += self.num_tests_failed
                
                passed_tests_num = pytest_pattern_.group("passed")
                if passed_tests_num:
                    self.num_tests_passed += int(passed_tests_num)
                    self.num_tests_run += self.num_tests_passed
                
                skipped_tests_num = pytest_pattern_.group("skipped")
                if skipped_tests_num:
                    self.num_tests_skipped += int(skipped_tests_num)
                    self.num_tests_run += self.num_tests_skipped
                
                deselected_tests_num = pytest_pattern_.group("deselected")
                if deselected_tests_num:
                    self.num_tests_deselected += int(deselected_tests_num)
                    self.num_tests_run += self.num_tests_deselected
                
                xfailed_tests_num = pytest_pattern_.group("xfail")
                if xfailed_tests_num:
                    self.num_tests_xfailed += int(xfailed_tests_num)
                    self.num_tests_run += self.num_tests_xfailed
                
                xpassed_tests_num = pytest_pattern_.group("xpass")
                if xpassed_tests_num:
                    self.num_tests_xpassed += int(xpassed_tests_num)
                    self.num_tests_run += self.num_tests_xpassed
                    
                self.test_duration += float(pytest_pattern_.group("secs"))
                
        return {
            "framework": self.framework,
            "num_tests_run": self.num_tests_run,
            "num_tests_failed": self.num_tests_failed,
            "num_tests_passed": self.num_tests_passed,
            "num_tests_skipped": self.num_tests_skipped,
            "num_tests_xfailed": self.num_tests_xfailed,
            "num_tests_xpassed": self.num_tests_xpassed,
            "tests_failed": self.tests_failed,
            "tests_skipped": self.tests_skipped,
            "test_duration": self.test_duration
        }
        
class UnitTestLogAnalyzer(BaseLogAnalyzer):
    def __init__(self, lines):
            super().__init__(lines)
            self.framework = "unittest"
            self.num_tests_xfailed = 0
            self.tests_xfailed = []
            self.num_tests_xpassed = 0
            self.tests_xpassed = []
            self.num_tests_deselected = 0
            self.short_summary = False
            
    def is_applicable(self):
        # Heuristics for regrtest logs
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        for raw in self.lines:
            line = ansi_escape.sub('', raw)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            if (
                "libregrtest" in line.lower()
                or "== tests result:" in line.lower()
                or line.startswith("Total tests:")
                or line.startswith("Total duration:")
                or line.startswith("running ")
            ):
                return True
        return False
    
    def analyze(self):
        passed_pattern = re.compile(r"(\d+)\s+tests\s+OK", re.IGNORECASE)
        # Total test files: run=498/497 failed=3 skipped=16 resource_denied=2 rerun=3
        # Total duration: 8 min 46 sec
        duration_pattern = re.compile(r"Total duration: (\d+\s*)(min)?\s*(\d+\s*)(sec)?", re.IGNORECASE)
        test_summary_pattern = re.compile(
            r"^Total\s+test\s+files:\s*"
            r"run=(?P<run>\d+)(?:/(?P<total>\d+))?\s*"
            r"(?:failed=(?P<failed>\d+)\s*)?"
            r"(?:skipped=(?P<skipped>\d+)\s*)?"
            r"(?:resource_denied=(?P<resdeny>\d+)\s*)?"
            r"(?:rerun=(?P<rerun>\d+)\s*)?",
            re.IGNORECASE
        )
        skip_test_pattern = re.compile(r"(\d+)\s+tests\s+skipped:", re.IGNORECASE)
        failed_test_pattern = re.compile(r"(\d+)\s+tests\s+failed:")
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        
        for line in self.lines:
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            passed_pattern_ = passed_pattern.search(line)
            if passed_pattern_:
                self.num_tests_passed = int(passed_pattern_.group(1))
            
            test_summary_pattern_ = test_summary_pattern.search(line)
            if test_summary_pattern_:
                self.num_tests_run = int(test_summary_pattern_.group("total"))
                failed_test_num = test_summary_pattern_.group("failed")
                if failed_test_num:
                    self.num_tests_failed = int(failed_test_num)
                skipped_tests_num = test_summary_pattern_.group("skipped")
                res_denied = test_summary_pattern_.group("resdeny")
                if skipped_tests_num or res_denied :
                    skipped = int(skipped_tests_num) if skipped_tests_num else 0
                    resource_denied = int(res_denied) if res_denied else 0
                    self.num_tests_skipped = skipped + resource_denied
            
            duration_pattern_ = duration_pattern.search(line)
            if duration_pattern_:
                minutes = float(duration_pattern_.group(1)) if duration_pattern_.group(1) else 0
                secs = float(duration_pattern_.group(3)) if duration_pattern_.group(3) else 0
                
                self.test_duration = (minutes*60) + secs
                
                
                    
        return {
            "framework": self.framework,
            "num_tests_run": self.num_tests_run,
            "num_tests_failed": self.num_tests_failed,
            "num_tests_passed": self.num_tests_passed,
            "num_tests_skipped": self.num_tests_skipped,
            "num_tests_xfailed": self.num_tests_xfailed,
            "num_tests_xpassed": self.num_tests_xpassed,
            "tests_failed": self.tests_failed,
            "tests_skipped": self.tests_skipped,
            "test_duration": self.test_duration
        }    
                
            
        
             
# def detect_analyzer(log_lines):
#     analyzers = [
#         PytestLogAnalyzer,
#         UnitTestLogAnalyzer
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

# log_lines = read_log_file("log.txt")
    
# analyzer = detect_analyzer(log_lines)
    
# if analyzer:
#     results = analyzer.analyze()
#     print(results)
# else:
#     print("No applicable analyzer found for this log.")   
                
                
