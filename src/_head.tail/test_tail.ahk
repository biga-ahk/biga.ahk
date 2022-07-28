;; Display test results in GUI
speed := QPC(0)
sleep, 200 ; allow callback tests to complete
assert.fullReport()
assert.writeResultsToFile()
msgbox, % speed
exitApp

QPC(R := 0)
{
	static P := 0, F := 0, Q := dllCall("QueryPerformanceFrequency", "Int64P", F)
	return ! dllCall("QueryPerformanceCounter", "Int64P", Q) + (R ? (P := Q) / F : (Q - P) / F)
}
