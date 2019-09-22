SetBatchLines -1 ;Go as fast as CPU will allow
#NoTrayIcon
#SingleInstance force


#include %A_ScriptDir%\lib
#include biga.ahk\export-manual.ahk
; #include transformStringVars.ahk\export.ahk
; #include util-array.ahk\export.ahk
; #include json.ahk\export.ahk
; #include wrappers.ahk\export.ahk
#include util-misc.ahk\export.ahk


; Globals
A := new biga()
docsRegEx := "\*\*DOC\*\*([\s\S]*?)\*\*\*"
testsRegEx := "\*\*Tests\*\*([\s\S]*?)\*\*\*"
categoryRegEx := "(\w+)\\\w+\.\w{3}"
newline := "`r`n" ;do not change this as docsify needs `r

; Test RegEx
testtest := "test\(A(\.\w*.*\)),\s*(.*)\)"
testtrue := "true\(A(\.\w+)(.+\))\)"
testfalse := "false\(A(\.\w+)(.+\))\)"
testnotequal := "notequal\(A(\.\w*.*\)),\s*(.*)\)"

; Files
Readme_File := A_ScriptDir "\docs\README.md"
lib_File := A_ScriptDir "\lib\biga.ahk\export-built.ahk"
test_File := A_ScriptDir "\lib\biga.ahk\test.ahk"

Ignoremethods := ["internal","matches"]

The_Array := []
msgarray := []

; method names
vMethodNames_Array := []

loop, Files, %A_ScriptDir%\src\*.ahk, R
{
    if (A.includes(A_LoopFileName,"head") || A.includes(A_LoopFileName,"tail")) {
        continue
    }
    FileRead, The_MemoryFile, % A_LoopFileFullPath
    
    ; chunk that b
    bbb := {}
    bbb.raw := The_MemoryFile
    ; bbb.name := SubStr(A_LoopFileName,1,StrLen(A_LoopFileName) - 4)
    bbb.name := A.split(A_LoopFileName,".")[1]
    ; bbb.test := Fn_QuickRegEx(bbb.raw,testsRegEx)
    bbb.category := Fn_QuickRegEx(A_LoopFileFullPath,categoryRegEx)
    ; msgbox, % bbb.name " -  " bbb.category

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

    bbb.doc := A.replace(bbb.doc,"/\#{1,10}\s*Returns*/", "#### Returns") ;replace accidental headers
    bbb.doc := A.replace(bbb.doc,"/\#{1,10}\s*Arguments*/", "#### Arguments") ;replace accidental headers
    bbb.doc := A.replace(bbb.doc,"/\#{1,10}\s*Examples*/", "#### Example") ;replace accidental headers
    bbb.doc := A.replace(bbb.doc,");", ")") ;replace accidental js semicolons
    The_Array.push(bbb)
}
; The_Array := A.sortBy(The_Array,["name", "category"])
; Array_Gui(The_Array)
if (IsObject(msgarray)) {
    msgbox, % A.join(msgarray, newline)
}

; ===============
; TESTS
; ===============

FileDelete, % test_File
test_head := fn_ReadFile(A_ScriptDir "\src\_head.tail\test_head.ahk")
test_tail := fn_ReadFile(A_ScriptDir "\src\_head.tail\test_tail.ahk")

FileAppend, %test_head%, % test_File
loop, % The_Array.MaxIndex() {
    element := The_Array[A_Index]
    FileAppend, % newline "assert.label(""" element.name "()""" ")", % test_File
    FileAppend, % element.tests newline newline newline newline newline, % test_File
    
}
FileAppend, %test_tail%, % test_File

; ===============
; TESTS
; ===============
loop, % The_Array.Count() {
    element := The_Array[A_Index]
    vMethodNames_Array.push(element.name)
}
clipboard := A.join(vMethodNames_Array," ")


; ===============
; DOCS
; ===============
FileDelete, % Readme_File
DOCS_Array := []
loop, % The_Array.MaxIndex() {
    element := The_Array[A_Index]
    if (A.indexof(Ignoremethods,element.name) != -1) { ; skip ignored methods
        continue
    }
    txt := []
    ExampleArray := []
    if (element.category != The_Array[A_Index - 1].category) {
        txt.push(newline "# **" A.startCase(element.category) "**" newline)
    }
    txt.push("## " "." element.name newline element.doc newline newline)
    ; if examples not staticly defined in .md file, parse tests for use in documentation
    if (!A.includes(element.doc,"Example") && A.includes(element.tests, "A.")) {
        txt.push("#### Example" newline newline "``````autohotkey" newline)
        ExampleArray := fn_BuildExample(StrSplit(element.tests, "`n"))
        ExampleArray.push("``````" newline newline)
        txt := A.concat(txt,ExampleArray)
    }
    txt.push(newline newline newline)
    DOCS_Array := A.concat(DOCS_Array,txt)
}
loop, % DOCS_Array.MaxIndex() {
    FileAppend, % DOCS_Array[A_Index], % Readme_File
}



; ===============
; LIBRARY EXPORT
; ===============
lib_array := A.map(The_Array,Func("fn_AddIndent"))
fn_AddIndent(value) {
    global
    x := A.replace(value.lib,"/m)^(.+)/",A_Tab "$1")
    x := A.replace(x,"/m`n)^([\s\n\r]*)$/","")
    x := A.replace(x,"/m`n)(^[\s\n\r]*$)/","")
    return x
}
FileDelete, % lib_File
lib_head := A.split(fn_ReadFile(A_ScriptDir "\src\_head.tail\lib_head.ahk"))
lib_tail := A.split("}`n")
lib_txt := A.join(A.concat(lib_head,lib_array,lib_tail),"")
FileAppend, %lib_txt%, % lib_File

; exitmsg := A.join(msgarray, "`n")
sleep, 500
Run, %test_File%, % A_ScriptDir "/lib/biga.ahk"
ExitApp, 1




; /--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
; functions
; \--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/


fn_BuildExample(param_tests) {
    ; Input - > array containing `n separated textfile of assert.{{x}} tests
    ; Output - > array suitable for export to markdown for example code
    global
    return_array := []

    for Key, Value in param_tests {
        if (A.includes(Value,"; omit")) {
            break
        }

        hey := Fn_QuickRegEx(Value,testtest,0)
        if (hey.count() = 2) {
            return_array.push("A" hey.Value(1) "`n; => " hey.Value(2) newline newline)
            continue
        }
        hey := Fn_QuickRegEx(Value,testnotequal,0)
        if (hey.count() = 2) {
            return_array.push("A" hey.Value(1) "`n; => " hey.Value(2) newline newline)
            continue
        }
        hey := Fn_QuickRegEx(Value,testtrue,0)
        if (hey.count() = 2) {
            return_array.push("A" hey.Value(1) hey.Value(2) "`n; => true" newline newline)
            continue
        }
        hey := Fn_QuickRegEx(Value,testfalse,0)
        if (hey.count() = 2) {
            return_array.push("A" hey.Value(1) hey.Value(2)"`n; => false" newline newline)
            continue
        }

        if (A.size(Value) > 1) {
            return_array.push(Value)
        }
    }
    return return_array
}

fn_ReadFile(param_FileToRead) {
    FileRead, l_MemoryFile, % param_FileToRead
    return l_MemoryFile
}
