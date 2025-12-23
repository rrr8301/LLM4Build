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
    
class JavaMavenLogAnalyser(BaseLogAnalyzer):
    def __init__(self, lines):
        super().__init__(lines)
        self.framework = "Maven"
        
    def is_applicable(self):
        return any(re.search(r'\bMaven\b', line, re.IGNORECASE) for line in self.lines)
    
    def get_int_from_match(self, match):
        return int(re.sub(r'\D', '', match)) if match else 0
    
    def extract_failed_tests(self):
        cur_test_class = ''
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        for line in self.lines:
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            # Matches the likes of:
            # Tests run: 11, Failures: 2, Errors: 0, Skipped: 0, Time elapsed: 0.1 sec <<< FAILURE! - in path.to.TestCls
            match = re.search(r'<<< FAILURE! --? in ([\w\.]+)', line, re.M)
            if match:
                cur_test_class = match.group(1)
            elif match := re.match(r'(?:\[INFO\] )?Running ([\w\.]+)$', line, re.M):
                cur_test_class = match.group(1)
            elif re.search(r'(<<< FAILURE!?|<<< ERROR!?)\s*$', line, re.M):
                re_log_error = r'(?:(?:\d+ )?\[ERROR\] )'
                # Matches the path to the test class.
                # The [secure] part is an edge case; see test_maven_5 in the Travis analyzer tests.
                re_test_class = r'(?:[\w$]+(?:\.(?:[\w$]+|\[secure\]))*)'
                # Matches the test method's name.
                # EDGE CASE: Some artifacts (e.g. square-moshi-610576045) write their tests in Kotlin, which allows
                # spaces in method names.
                re_method_name = r'(?:[\w$ ]+)'
                # Matches parameterized test info. There are three variants depending on the test runner:
                # junit4: methodName[1], methodName[<arbitrary string>]
                # juint5: methodName(float, String)[1] or methodName{ArgumentsAccessor}[1]
                # testng: methodName[3.5, foo](1)
                re_method_params = r'(?:\[.+\]|(?:\([\w, ]*\)|\{ArgumentsAccessor\})\[\d+\]|\[.*\]\(\d+\))'
                re_time_elapsed = r'(?:(?:--)? Time elapsed:)'
                failedtest = None

                # Matches the likes of [ERROR] testMethod(path.to.testClass)  Time elapsed: 0.022 s  <<< ERROR!
                # Sets failedtest to 'testMethod(path.to.testClass)'
                regex = r'{}?({}{}?\({}\)) {}'.format(re_log_error, re_method_name,
                                                      re_method_params, re_test_class, re_time_elapsed)
                match = re.match(regex, line, re.M)
                if match:
                    failedtest = match.group(1)
                if failedtest is None:
                    # Matches the likes of [ERROR] testMethod  Time elapsed: 0.011 sec  <<< FAILURE!
                    # Assuming that cur_test_class == 'path.to.TestCls', sets failedtest = 'testMethod(path.to.TestCls)'
                    regex = r'{}?({}{}?) {}'.format(re_log_error, re_method_name, re_method_params, re_time_elapsed)
                    match = re.match(regex, line, re.M)
                    if match:
                        failedtest = match.group(1) + '(' + cur_test_class + ')'
                if failedtest is None and cur_test_class:
                    # Matches the likes of [ERROR] path.to.TestClass  Time elapsed: 0.011 sec  <<< FAILURE!
                    # Sets failedtest to (path.to.TestClass)
                    regex = r'{}?{} {}'.format(re_log_error, re.escape(cur_test_class), re_time_elapsed)
                    match = re.match(regex, line, re.M)
                    if match:
                        failedtest = '(' + cur_test_class + ')'
                if failedtest is None:
                    # Matches the likes of [ERROR] path.to.TestClass.testMethod  Time elapsed: 0.011 sec  <<< FAILURE!
                    # This sets failedtest to 'testMethod(path.to.TestClass)'
                    regex = r'{}?({})\.({}{}?) {}'.format(
                        re_log_error, re_test_class, re_method_name, re_method_params, re_time_elapsed
                    )
                    match = re.match(regex, line, re.M)
                    if match:
                        failedtest = match.group(2) + '(' + match.group(1) + ')'
                if failedtest is None:
                    # Matches the likes of [ERROR] path.to.TestClass  Time elapsed: 0.011 sec  <<< FAILURE!
                    # This condition is only reached if the name of the test method is not present in the log.
                    # This sets failedtest to '(path.to.TestClass)'
                    match = re.search(r'^(\[ERROR\] )?([\w.]+)( --)? Time elapsed:', line, re.M)
                    if match:
                        failedtest = '(' + match.group(2) + ')'
                if failedtest is not None:
                    self.tests_failed.append(failedtest)
    
    def analyze(self):
        result_block_start = False
        result_block_pattern = re.compile(r"(\[INFO\])?\s*Results", re.IGNORECASE)
        result_pattern = re.compile(
            r"^\[(?P<level>INFO|WARNING|ERROR)\]\s*"
            r"Tests\s+run:\s*(?P<run>\d+),\s*"
            r"Failures:\s*(?P<failures>\d+),\s*"
            r"Errors:\s*(?P<errors>\d+),\s*"
            r"Skipped:\s*(?P<skipped>\d+)\s*$",
            re.IGNORECASE
        )
        
        
        duration_pattern = re.compile(
            r"^\[(?P<level>INFO|WARNING|ERROR)\]\s*"
            r"Total\s+time:\s*(?P<minutes>\d{1,2}):(?P<seconds>\d{2})\s*(min|hrs?)",
            re.IGNORECASE
        )
        
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        
        for line in self.lines:
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            
            # error_block = error_or_failure_block.search(line)
            # if error_block and result_block_start:
            #     error_or_failure_block_start = True
            #     continue
            
            # if error_or_failure_block_start and result_block_start:
            #     error = error_or_failure_test_pattern.search(line)
            #     if error:
            #         self.tests_failed.append(error.group("testname"))
            
            result_block = result_block_pattern.search(line)
            
            if result_block:
                result_block_start = True
                # error_or_failure_block_start = False
                continue
            
            if result_block_start == True:
                result = result_pattern.search(line)
                print(result)
                if result:
                    self.num_tests_run += int(result.group("run"))
                    self.num_tests_failed += (int(result.group("failures")) + int(result.group("errors")))
                    self.num_tests_skipped += int(result.group("skipped"))
                    result_block_start = False
                    
                    
            duration = duration_pattern.search(line)
            if duration:
                mm = int(duration.group("minutes"))
                ss = int(duration.group("seconds"))
                self.test_duration = float((mm*60) + ss)
            
        self.num_tests_passed = self.num_tests_run - (self.num_tests_failed + self.num_tests_skipped)
        # self.test_duration = 
        self.extract_failed_tests()
            
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
        

class JavaGradleLoganalyzer(BaseLogAnalyzer):
    def __init__(self, lines):
        super().__init__(lines)
        self.framework = "Gradle"
        
    def is_applicable(self):
        return any(re.search(r'\bGradle\b', line, re.IGNORECASE) for line in self.lines)       

    def convert_gradle_time_to_seconds(s):
        match = re.search(r'((\d+) mins)? (\d+)(\.\d+) secs', s, re.M)
        if match:
            # If we have minute, we add 60 * minutes to the seconds, final unit is seconds
            return int(match.group(3)) if match.group(2) is None else int(match.group(2)) * 60 + int(match.group(3))

        match = re.search(r'((\d+)m )?(\d+)s', s, re.M)
        if match:
            # If we have minute, we add 60 * minutes to the seconds, final unit is seconds
            print(match)
            return int(match.group(3)) if match.group(2) is None else int(match.group(2)) * 60 + int(match.group(3))

        return 0
    
    def analyze(self):
        ansi_escape = re.compile(r'\x1B[@-_][0-?]*[ -/]*[@-~]', re.M)
        
        for line in self.lines:
            line = ansi_escape.sub('', line)
            line = re.sub(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', '', line)
            
            match = re.search(r'(\d*) tests completed(, (\d*) failed)?(, (\d*) skipped)?', line, re.M)
            if match:
                failed = 0 if match.group(3) is None else int(match.group(3))
                skipped = 0 if match.group(5) is None else int(match.group(5))
                run = int(match.group(1))
                passed = run - (passed + skipped)
                self.num_tests_run += run
                self.num_tests_failed += failed
                self.num_tests_skipped += skipped
                self.num_tests_run += passed
                continue
            
            match = re.search(r'^Total tests run: (\d+), Failures: (\d+), Skips: (\d+)', line, re.M)
            if match:
                self.num_tests_run += int(match.group(1))
                self.num_tests_failed += int(match.group(2))
                self.num_tests_skipped += int(match.group(3))
                continue
            
            # Gradle Test Run :core:S3UnitTest > Gradle Test Executor 14 > EventTest > testCommitRequestCodec() PASSED
            # Gradle Test Run :core:S3UnitTest > Gradle Test Executor 14 > ElasticReplicaManagerTest > testReplicaNotAvailable() SKIPPED
            # BUILD SUCCESSFUL in 5m 25s
            match = re.search(r'^Gradle\s*Test\s*Run\s*:(.*) > (.*) > (.*) > (.*) (PASSED|SKIPPED|FAILED)', line, re.M)
            if match:
                test_class = match.group(3)
                test_function = match.group(4)
                p_s_f = match.group(5)
                if p_s_f == 'PASSED':
                    self.num_tests_passed += 1
                    self.num_tests_run += 1
                elif p_s_f == "SKIPPED":
                    self.num_tests_skipped += 1
                    self.num_tests_run += 1
                    self.tests_skipped.append(test_class + '.' + test_function)
                elif p_s_f == "FAILED":
                    self.num_tests_failed += 1
                    self.num_tests_run += 1
                    self.tests_failed.append(test_class + '.' + test_function)
                continue
            
            # match = re.search(r'Total time: (.*)', line, re.M)
            # if match:
            #     self.test_duration += self.convert_gradle_time_to_seconds(match.group(1))

            # match = re.search(r'BUILD (FAILED|SUCCESSFUL) in (.*)', line, re.M)
            # if match:
            #     print(match.group(2))
            #     self.test_duration += self.convert_gradle_time_to_seconds(match.group(2))
            # 2221 passing (2m 20s)
            # 73 pending
            match = re.search(r'^\s*(\d+)\s+passing\s*\(\s*(?:(\d+)m)?\s*(?:(\d+(?:\.\d+)?)s)?\s*\)\s*$', line, re.M)
            if match:
                self.num_tests_passed += int(match.group(1))
                self.num_tests_run += int(match.group(1))
                # hr = 0.0 if match.group(2) is None else float(match.group(2))
                mm = 0.0 if match.group(2) is None else float(match.group(2))
                sec = 0.0 if match.group(3) is None else float(match.group(3))
                self.test_duration += (mm*60) + sec
                
            match = re.search(r'\s*(\d+)\s*pending', line, re.M)
            if match:
                self.num_tests_skipped += int(match.group(1))
                self.num_tests_run += int(match.group(1))
            
        return {
            "framework": self.framework,
            "num_tests_run": self.num_tests_run,
            "num_tests_passed": self.num_tests_passed,
            "num_tests_failed": self.num_tests_failed,
            "num_tests_passed": self.num_tests_passed,
            "num_tests_skipped": self.num_tests_skipped,
            "tests_failed": self.tests_failed,
            "tests_skipped": self.tests_skipped,
            "test_duration": self.test_duration
        }
    
    
        
# def detect_analyzer(log_lines):
#     analyzers = [
#         JavaMavenLogAnalyser,
#         JavaGradleLoganalyzer
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

# log_lines = read_log_file("automq-55904790251.log")
    
# analyzer = detect_analyzer(log_lines)
    
# if analyzer:
#     results = analyzer.analyze()
#     print(results)
# else:
#     print("No applicable analyzer found for this log.")   
                
                


        