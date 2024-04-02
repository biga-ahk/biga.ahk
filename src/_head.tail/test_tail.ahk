;; Display test results in GUI
sleep, 200 ; allow callback tests to complete
assert.fullReport()
assert.writeResultsToFile()
exitApp