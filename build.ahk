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
; testtest := "test\(.*\),\s*(.*)\)"
testtest := "test\(A\.\w*(.*\)),\s*(.*)\)"
testtrue := "true\(.*\(.+?,(.+)\)\)"
testfalse := "false\(.*\(.+?,(.+)\)\)"

; Files
Readme_File := A_ScriptDir "\docs\README.md"
lib_File := A_ScriptDir "\lib\biga.ahk\export-built.ahk"
test_File := A_ScriptDir "\lib\biga.ahk\test.ahk"

The_Array := []
msgarray := []

loop, Files, %A_ScriptDir%\src\*.ahk, R
{
    FileRead, The_MemoryFile, % A_LoopFileFullPath
    
    ; chunk that b
    bbb := {}
    bbb.name := SubStr(A_LoopFileName,1,StrLen(A_LoopFileName) - 4)
    bbb.raw := The_MemoryFile
    ; bbb.test := Fn_QuickRegEx(bbb.raw,testsRegEx)
    bbb.category := Fn_QuickRegEx(A_LoopFileFullPath,categoryRegEx)
    clipboard := A_LoopFileFullPath

    ; markdown file
    markdown_File := A_LoopFileDir "\" bbb.name ".md"
    if (!FileExist(markdown_File)) {
        msgarray.push(markdown_File " does not exist")
    }
    FileRead, The_MemoryFile, % markdown_File
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
if (msgarray.length > 0) {
    msgbox, % A.join(msgarray, newline)
}


; ===============
; DOCS
; ===============
FileDelete, % Readme_File
DOCS_Array := []
loop, % The_Array.MaxIndex() {
    element := The_Array[A_Index]
    txt := ["# " "." element.name newline element.doc newline newline]

    ; if examples not staticly defined in .md file
    if (!A.includes(element.doc,"Example") && A.includes(element.tests, "A.")) {
        txt.push("#### Example" newline newline "``````autohotkey" newline)
        ExampleArray := StrSplit(element.tests, "`n")
        ExampleArray := fn_BuildExample(ExampleArray)
        ExampleArray.push("``````" newline newline)
        txt := A.concat(txt,ExampleArray)
    }
    txt.push("*******" newline newline newline)

    DOCS_Array := A.concat(DOCS_Array,txt)
}
loop, % DOCS_Array.MaxIndex() {
    FileAppend, % DOCS_Array[A_Index], % Readme_File
}


; ===============
; LIBRARY EXPORT
; ===============
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



; ===============
; TESTS
; ===============
FileDelete, % test_File
head = 
(
    #Include export.ahk
    #Include ..\unit-testing.ahk\export.ahk
    #Include ..\util-array.ahk\export.ahk
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

; /--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
; functions
; \--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/
fn_BuildExample(param_tests) {
    global
    return_array := []

    for Key, Value in param_tests
    {
        hey := Fn_QuickRegEx(Value,testtest,0)
        if (hey.count() = 2) {
            return_array.push("A." element.name hey.Value(1) "`n; => " hey.Value(2) newline newline)
        } else if (StrLen(Value) > 4) {
            return_array.push(Value)
        }
    }

    return return_array
}