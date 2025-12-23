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
        self.tests_passed = []
        self.tests_run = []
        self.framework = None

    def analyze(self):
        raise NotImplementedError("Subclasses should implement this method")
    
    def is_applicable(self):
        """Our Analyzers can override this and use to check logs searching for something unique to them 
        and determine if the logfile applies to them"""
        return False

        
class CTEST_LogAnalyzer(BaseLogAnalyzer):
    def __init__(self, lines):
        super().__init__(lines)
        self.framework = "CTest"
    
    def is_applicable(self):
        run_test_pattern = re.compile(
            r"^\s*(?P<pct>\d+(?:\.\d+)?)%\s*tests?\s*passed,\s*"
            r"(?P<failed>\d+)\s*tests?\s*failed\s*out\s*of\s*(?P<total>\d+)\s*$",
            re.IGNORECASE
        )
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        for raw in self.lines:
            line = ansi_escape.sub('', raw)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            if run_test_pattern.match(line):
                return True
        return False
    
    def get_int_from_match(self, match):
        return int(re.sub(r'\D', '', match)) if match else 0
    
    def analyze(self):
        SKIPPED_HDR = re.compile(r"^\s*The following tests did not run:\s*$")
        item_skipped = re.compile(r"^\s*(\d+)\s*-\s*(.*?)\s*\(([^)]+)\)\s*$")
        FAILED_HDR = re.compile(r"^\s*The following tests FAILED:\s*$")
        item_failed = re.compile(r"^\s*(\d+)\s*-\s*(.*?)\s*\(([^)]+)\)\s*$")
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        c_test_pattern = re.compile(
            r"^\s*(?P<pct>\d+(?:\.\d+)?)%\s*tests?\s*passed,\s*"
            r"(?P<failed>\d+)\s*tests?\s*failed\s*out\s*of\s*(?P<total>\d+)\s*$",
            re.IGNORECASE
        )
        c_test_duration_pattern = re.compile(
            r"^Total\s+Test\s+time\s*\(real\)\s*=\s*(?P<time>[\d.]+)\s*sec",
            re.IGNORECASE
        )
        skipped_section = False
        Failed_section = False
        for line in self.lines:
            # jest_tests = re.search(r'Tests:\s+(\d+ failed, )?(\d+ skipped, )?(\d+ passed, )?(\d+ total)', line)
            # jest_time = re.search(r'Time:\s+(\d+\.?\d*)\s?s', line)
            # Total Test time (real) =  64.25 sec
            # 99% tests passed, 1 tests failed out of 3601
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            c_tests = c_test_pattern.search(line)
            c_duration = c_test_duration_pattern.search(line)
            # SKIPPED_HDR = re.compile(r"^\s*The following tests did not run:\s*$")
            # item_skipped = re.compile(r"^\s*(\d+)\s*-\s*(.*?)\s*\(([^)]+)\)\s*$")
            # FAILED_HDR = re.compile(r"^\s*The following tests FAILED:\s*$")
            # item_failed = re.compile(r"^\s*(\d+)\s*-\s*(.*?)\s*\(([^)]+)\)\s*$")
            
            if c_tests:
                c_total = int(c_tests.group("total"))
                self.num_tests_run += c_total
                
                c_failed = int(c_tests.group("failed"))
                self.num_tests_failed += c_failed
            
            if c_duration:
                self.test_duration += float(c_duration.group("time"))
            
            
            if SKIPPED_HDR.match(line):
                skipped_section = True
                continue
            
            if FAILED_HDR.match(line):
                Failed_section = True
                skipped_section = False
                continue
            
            if skipped_section == True:
                item_skipped_ = item_skipped.search(line)
                if item_skipped_:
                    self.tests_skipped.append(item_skipped_.group(2))
            elif Failed_section == True:
                item_failed_ = item_failed.search(line)
                if item_failed_:
                    self.tests_failed.append(item_failed_.group(2))
                    
            self.num_tests_skipped = len(self.tests_skipped)
            self.num_tests_passed = self.num_tests_run - self.num_tests_skipped - self.num_tests_failed
                    
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
                    
        


class GTest_LogAnalyzer(BaseLogAnalyzer):
    def __init__(self, lines):
        super().__init__(lines)
        self.framework = "GTest"
    
    def is_applicable(self):
        run_test_pattern = re.compile(
            r"\[\=+\]\s*"
            r"(?P<tests>\d+)\s+tests?\s+from\s+(?P<cases>\d+)\s+test\s+cases?\s+ran\.\s*"
            r"\((?P<time>[\d.]+)\s*ms\s*total\)",
            re.IGNORECASE
        )
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        
        for line in self.lines:
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            c_tests_run = run_test_pattern.search(line)
            if c_tests_run:
                return True
        return False
            
    
    def get_int_from_match(self, match):
        return int(re.sub(r'\D', '', match)) if match else 0

    def analyze(self):
        passed_pattern = re.compile(r"\s*\[\s*PASSED\s*\]\s*(?P<passed>\d+)\s+tests?", re.IGNORECASE)
        failed_count_pattern = re.compile(r"\s*\[\s*FAILED\s*\]\s*(?P<failed>\d+)\s+tests?", re.IGNORECASE)
        skipped_pattern = re.compile(r"\s*\[\s*SKIPSTAT\s*\]\s*(?P<skipped>\d+)\s+tests?\s+skipped", re.IGNORECASE)
        failed_test_pattern = re.compile(
            r"\s*\[\s*FAILED\s*\]\s+(?P<name>[\w:./-]+)", re.IGNORECASE
        )
        run_test_pattern = re.compile(
            r"\[\=+\]\s*"
            r"(?P<tests>\d+)\s+tests?\s+from\s+(?P<cases>\d+)\s+test\s+cases?\s+ran\.\s*"
            r"\((?P<time>[\d.]+)\s*ms\s*total\)",
            re.IGNORECASE
        )
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        
        for line in self.lines:
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            c_passed = passed_pattern.search(line)
            c_failed = failed_count_pattern.search(line)
            c_skipped = skipped_pattern.search(line)
            c_failed_test = failed_test_pattern.search(line)
            c_tests_run = run_test_pattern.search(line)
            
            if c_passed:
                c_passed_num = int(c_passed.group("passed"))
                self.num_tests_passed += c_passed_num
                
            if c_failed:
                c_failed_num = int(c_failed.group("failed"))
                self.num_tests_failed += c_failed_num
                
            if c_skipped:
                c_skipped_num = int(c_skipped.group("skipped"))
                self.num_tests_skipped += c_skipped_num
                
            if c_failed_test:
                self.tests_failed.append(c_failed_test.group("name"))
                
            if c_tests_run:
                c_tests_run_ = int(c_tests_run.group("tests"))
                self.num_tests_run += c_tests_run_
                c_tests_duration = float(c_tests_run.group("time"))
                self.test_duration += c_tests_duration
                
        return {
            "framework": self.framework,
            "num_tests_run": self.num_tests_run,
            "num_tests_failed": self.num_tests_failed,
            "num_tests_passed": self.num_tests_passed,
            "num_tests_skipped": self.num_tests_skipped,
            "tests_failed": self.tests_failed,
            "tests_skipped": self.tests_skipped,
            "test_duration": self.test_duration/1000
        }
                
            
class NinjaLogAnalyzer(BaseLogAnalyzer):                
        def __init__(self, lines):
            super().__init__(lines)
            self.framework = "GitTest"
        
        def is_applicable(self):
            run_test_pattern = re.compile(
                r"\[\=+\]\s*"
                r"(?P<tests>\d+)\s+tests?\s+from\s+(?P<cases>\d+)\s+test\s+cases?\s+ran\.\s*"
                r"\((?P<time>[\d.]+)\s*ms\s*total\)",
                re.IGNORECASE
            )
            ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
            for raw in self.lines:
                line = ansi_escape.sub('', raw)
                line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
                if run_test_pattern.match(line):
                    return True
            return False
        
        def get_int_from_match(self, match):
            return int(re.sub(r'\D', '', match)) if match else 0  
        
        def analyze(self):
            return  
                
class GitTest_Loganalyzer(BaseLogAnalyzer):
    def __init__(self, lines):
        super().__init__(lines)
        self.framework = "GitTest"
    
    def is_applicable(self):
        run_test_pattern = re.compile(
            r'^\s*(?P<idx>\d+)\/(?P<total>\d+)\s+'
            r'(?P<module>\S+)\s*\/\s*(?P<name>\S+)\s+'
            r'(?P<status>OK|FAIL|ERROR|SKIP)\s+'
            r'(?P<secs>\d+(?:\.\d+)?)s\s*$'
        )
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        for raw in self.lines:
            line = ansi_escape.sub('', raw)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            if run_test_pattern.match(line):
                return True
        return False
    
    def get_int_from_match(self, match):
        return int(re.sub(r'\D', '', match)) if match else 0
    
    
class MesonLoganalyzer(BaseLogAnalyzer):
    def __init__(self, lines):
        super().__init__(lines)
        self.framework = "Meson"
    
    def is_applicable(self):
        run_test_pattern = re.compile(
            r'^\s*(?P<idx>\d+)\/(?P<total>\d+)\s+'
            r'(?P<module>\S+)\s*\/\s*(?P<name>\S+)\s+'
            r'(?P<status>OK|FAIL|ERROR|SKIP)\s+'
            r'(?P<secs>\d+(?:\.\d+)?)s\s*$'
        )
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        for raw in self.lines:
            line = ansi_escape.sub('', raw)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            if run_test_pattern.match(line):
                return True
        return False
    
    def get_int_from_match(self, match):
        return int(re.sub(r'\D', '', match)) if match else 0
    
    def analyze(self):
        passed_test_num_re = re.compile(r'^\s*Ok:\s*(\d+)\s*$')
        failed_test_num_re = re.compile(r'^\s*fail:\s*(\d+)\s*$')
        skipped_test_num_re = re.compile(r'^\s*skip:\s*(\d+)\s*$')
        run_test_pattern = re.compile(
            r'^\s*(?P<idx>\d+)\/(?P<total>\d+)\s+'
            r'(?P<module>\S+)\s*\/\s*(?P<name>\S+)\s+'
            r'(?P<status>OK|FAIL|ERROR|SKIP)\s+'
            r'(?P<secs>\d+(?:\.\d+)?)s\s*$'
        )
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        for line in self.lines:
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            m = passed_test_num_re.match(line)
            if m:
                self.num_tests_passed = int(m.group(1))
            
            n = failed_test_num_re.match(line)
            if n:
                self.num_tests_failed = int(n.group(1))
            
            s = skipped_test_num_re.match(line)
            if s:
                self.num_tests_skipped = int(s.group(1))
                
            run_test = run_test_pattern.match(line)
            status = run_test.group('status')
            module = run_test.group("module")
            test_name = run_test.group("test_name")
            time = run_test.group("secs")
            if status == 'OK':
                self.tests_passed.append(module + "/" + test_name)
            elif status == "FAIL":
                self.tests_failed.append(module + "/" + test_name)
            elif status == "SKIP":
                self.tests_skipped.append(module + "/" + test_name)
                
            self.test_duration += time
                
            
            
        self.num_tests_run + self.num_tests_passed + self.num_tests_failed + self.num_tests_skipped
        
        return {
            "framework": self.framework,
            "num_tests_run": self.num_tests_run,
            "num_tests_failed": self.num_tests_failed,
            "num_tests_passed": self.num_tests_passed,
            "num_tests_skipped": self.num_tests_skipped,
            "tests_failed": self.tests_failed,
            "tests_skipped": self.tests_skipped,
            "test_duration": self.test_duration/1000
        }
        
class BazelLogAnalyzer(BaseLogAnalyzer):
    def __init__(self, lines):
        super().__init__(lines)
        self.framework = "Bazel"
    
    def is_applicable(self):
        run_test_pattern = re.compile(
            r'^\s*(?P<label>//\S+)\s+'
            r'(?P<status>PASSED|FAILED|SKIPPED)'
            r'(?:\s+in\s+(?P<secs>\d+(?:\.\d+)?)s)?\s*$'
        )
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        for raw in self.lines:
            line = ansi_escape.sub('', raw)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            if run_test_pattern.match(line):
                return True
        return False
    
    def get_int_from_match(self, match):
        return int(re.sub(r'\D', '', match)) if match else 0
    
    def analyze(self):
        run_test_pattern = re.compile(
            r'^\s*(?P<label>//\S+)\s+'
            r'(?P<status>PASSED|FAILED|SKIPPED)'
            r'(?:\s+in\s+(?P<secs>\d+(?:\.\d+)?)s)?\s*$'
        )
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        for line in self.lines:
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            run_test = run_test_pattern.match(line)
            label = run_test.group('label')
            status = run_test.group('status')
            time = run_test.group("secs")
            
            if status == "PASSED":
                self.num_tests_passed += 1
                self.tests_passed.append(label)
            elif status == "FAILED":
                self.num_tests_failed += 1
                self.tests_failed.append(label)
            elif status == "SKIPPED":
                self.num_tests_skipped += 1
                self.tests_skipped.append(label)
                
            self.test_duration += time
                
        self.tests_run = self.tests_passed + self.tests_failed + self.tests_skipped
        self.num_tests_run = len(self.tests_run)
        return {
            "framework": self.framework,
            "num_tests_run": self.num_tests_run,
            "num_tests_failed": self.num_tests_failed,
            "num_tests_passed": self.num_tests_passed,
            "num_tests_skipped": self.num_tests_skipped,
            "tests_failed": self.tests_failed,
            "tests_skipped": self.tests_skipped,
            "test_duration": self.test_duration/1000
        }
            
# def detect_analyzer(log_lines):
#     analyzers = [
#         CTEST_LogAnalyzer,
#         GTest_LogAnalyzer,
#         GitTest_Loganalyzer
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
                
                

