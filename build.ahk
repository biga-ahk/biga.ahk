SetBatchLines -1 ;Go as fast as CPU will allow
#NoTrayIcon
#SingleInstance force


#include %A_ScriptDir%\lib
#include biga.ahk\export.ahk
; #include transformStringVars.ahk\export.ahk
#include util-array.ahk\export.ahk
; #include json.ahk\export.ahk
; #include wrappers.ahk\export.ahk
#include util-misc.ahk\export.ahk


; Globals
A := new biga()
docsRegEx := "\*\*DOC\*\*([\s\S]*?)\*\*\*"
testsRegEx := "\*\*Tests\*\*([\s\S]*?)\*\*\*"
categoryRegEx := "(\w+)\\\w+\.\w{3}"
newline := "`r`n"

; Test RegEx
testtest := "test\(.*\),\s*(.*)\)"
testtrue := "true\(.*\(.+?,(.+)\)\)"
testfalse := "false\(.*\(.+?,(.+)\)\)"

; Files
Readme_File := A_ScriptDir "\docs\README.md"
lib_File := A_ScriptDir "\lib\biga.ahk\exporttest.ahk"
test_File := A_ScriptDir "\lib\biga.ahk\test.ahk"

The_Array := []

loop, Files, %A_ScriptDir%\blocks\*.ahk, R
{
    FileRead, The_MemoryFile, % A_LoopFileFullPath
    
    ; chunk that b
    bbb := {}
    bbb.name := SubStr(A_LoopFileName,1,StrLen(A_LoopFileName) - 4)
    bbb.raw := The_MemoryFile
    bbb.test := Fn_QuickRegEx(bbb.raw,testsRegEx)
    bbb.category := Fn_QuickRegEx(A_LoopFileFullPath,categoryRegEx)
    clipboard := A_LoopFileFullPath

    FileRead, The_MemoryFile, % A_LoopFileDir "\" bbb.name ".md"
    bbb.doc := The_MemoryFile

    ;lib
    bbb.lib := StrSplit(bbb.raw, "; tests")[1]
    ; tests
    bbb.tests := StrSplit(bbb.raw, "; tests")[2]
    ; msgbox, % bbb.tests

    bbb.doc := A.replace(bbb.doc,"/\#{1,10}\s*Returns*/", "#### Returns") ;replace accidental headers
    bbb.doc := A.replace(bbb.doc,"/\#{1,10}\s*Arguments*/", "#### Arguments") ;replace accidental headers
    bbb.doc := A.replace(bbb.doc,"/\#{1,10}\s*Examples*/", "#### Example") ;replace accidental headers
    bbb.doc := A.replace(bbb.doc,");", ")") ;replace accidental js semicolons
    The_Array.push(bbb)
}
; Array_Gui(The_Array)


FileDelete, % Readme_File
loop, % The_Array.MaxIndex() {
    element := The_Array[A_Index]
    ; A.startCase()
    txt := "# " "." element.name newline element.doc newline newline newline newline "*******" newline
    FileAppend, %txt%, % Readme_File
}


; Generate lib file
head =
(
    Class biga {

	__New() {
        this.info_Array
        this.caseSensitive := false
        this.limit := -1
	}

)
tail = 
(
    }
)
FileDelete, % lib_File
FileAppend, %head%, % test_File
loop, % The_Array.MaxIndex() {
    element := The_Array[A_Index].lib
    FileAppend, % element "`r`n", % lib_File
}
FileAppend, %tail%, % test_File



; Generate test file
FileDelete, % test_File
head = 
(
    #Include export.ahk
    #Include ..\unit-testing.ahk\export.ahk
    ; #Include ..\util-array.ahk\export.ahk
    ; #Include ..\util-misc.ahk\export.ahk
    #Include ..\json.ahk\export.ahk
    #NoTrayIcon
    #SingleInstance, force
    SetBatchLines, -1

    A := new biga()
    assert := new unittesting()

    ; Star timer
    Start := A_TickCount
    QPC(1)

)
tail = 
(
    ;; Display test results in GUI
    speed := QPC(0)
    assert.fullreport()

    ExitApp

    QPC(R := 0)
    {
        static P := 0, F := 0, Q := DllCall("QueryPerformanceFrequency", "Int64P", F)
        return ! DllCall("QueryPerformanceCounter", "Int64P", Q) + (R ? (P := Q) / F : (Q - P) / F) 
    }

)

FileAppend, %head%, % test_File
loop, % The_Array.MaxIndex() {
    element := The_Array[A_Index]
    FileAppend, % "assert.label(""" element.name "()""" ")" "`r`n", % test_File
    FileAppend, % element.tests "`r`n", % test_File

}
FileAppend, %tail%, % test_File



ExitApp, 1
