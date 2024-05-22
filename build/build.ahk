setBatchLines -1 ;Go as fast as CPU will allow
#noTrayIcon
#singleInstance force

#include %A_ScriptDir%\..\node_modules
#include biga.ahk\export.ahk
#include util-misc.ahk\export.ahk

; User updatable settings:
settings := {}
settings.objectName := "A"
aliasMap := {"head": ["first"], "forEach": ["each"], "forEachRight": ["eachRight"], "toPairs": ["entries"]}

; dev options
devOptions := {}
devOptions.msgboxMissingMethods := false
devOptions.clipboardMethods := false

; Globals
A := new biga()
docsRegEx := "\*\*DOC\*\*([\s\S]*?)\*\*\*"
testsRegEx := "\*\*Tests\*\*([\s\S]*?)\*\*\*"
categoryRegEx := "src\\(.+)\\\w+\.\w{2,3}"
newline := "`r`n" ; do not change this as docsify needs `r


; FilePaths
setWorkingDir, "\..\" A_ScriptDir
readmeFilePath := A_WorkingDir "\docs\README.md"
libraryFilePath := A_WorkingDir "\export.ahk"
testsFilePath := A_WorkingDir "\test\test-all.ahk"
methodsListFilePath := A_WorkingDir "\methodslist.txt"

; turn methods txt into a compacted array
fileRead, lodashMethodNamesArr, % methodsListFilePath
lodashMethodNamesArr := A.compact(A.map(strSplit(lodashMethodNamesArr, "`n", "`r")))

; Arrays that control doc and test output. For ommiting or only testing certain areas
ignoreMethodDocsArr := ["internal"]
ommitMethodsArr := [""]
onlyTestArr := [""]

dataArr := [] ; Holds main data
msgArr := []
; method names
methodNamesArr := []

; Test RegEx
testtest := "test\((\w+\w*.*\)),\s*(.*)\)"
testtrue := "true\((.+?)(\(.+\))\)"
testfalse := "false\((.+\.?\w+)(.+\))\)"
testnotequal := "notequal\(\w+(\.\w*.*\)),\s*(.*)\)"


loop, Files, %A_WorkingDir%\src\*.ahk, R
{
	fileRead, The_MemoryFile, % A_LoopFileFullPath

	bbb := {}
	bbb.raw := The_MemoryFile
	; bbb.name := SubStr(A_LoopFileName,1,strLen(A_LoopFileName) - 4)
	bbb.name := A.split(A_LoopFileName, ".")[1]
	; bbb.test := Fn_QuickRegEx(bbb.raw,testsRegEx)
	bbb.category := Fn_QuickRegEx(A_LoopFileFullPath, categoryRegEx)
	; msgbox, % bbb.name " -  " bbb.category
	if (bbb.category = "_head.tail") { ; skip head and tail folder
		continue
	}

	; ommit if noted
	if (A.includes(bbb.raw, "/\;\s?\#{1,10}\s?incomplete\s?\#{1,10}/")) {
		continue
	}
	if (A.includes(ommitMethodsArr, bbb.name)) {
		continue
	}

	; markdown file
	markdown_file := A_LoopFileDir "\" bbb.name ".md"
	if (!fileExist(markdown_file) && bbb.name != "internal") {
		msgArr.push(markdown_file " does not exist")
		continue
	}
	fileRead, The_MemoryFile, % markdown_file
	bbb.doc := The_MemoryFile

	; lib
	bbb.lib := strSplit(bbb.raw, "; tests")[1]
	; tests
	bbb.tests := strSplit(bbb.raw, "; tests")[2]

	; replace accidental headers
	bbb.doc := A.replace(bbb.doc,"/\#{1,10}\s*Returns*/", "#### Returns")
	bbb.doc := A.replace(bbb.doc,"/\#{1,10}\s*Arguments*/", "#### Arguments")
	bbb.doc := A.replace(bbb.doc,"/\#{1,10}\s*Examples*/", "#### Example")
	bbb.doc := A.replace(bbb.doc,"/\#{1,10}\s*Aliases*/", "#### Aliases")
	bbb.doc := A.replace(bbb.doc,");", ")") ; replace accidental js semicolons
	dataArr.push(bbb)
}


; ===============
; TESTS
; ===============

fileDelete, % testsFilePath
test_head := fn_readFile(A_WorkingDir "\src\_head.tail\test_head.ahk")
test_tail := fn_readFile(A_WorkingDir "\src\_head.tail\test_tail.ahk")

fileAppend, %test_head%, % testsFilePath
loop, % dataArr.count() {
	element := dataArr[A_Index]
	; perform the tests if in specific array or specific array is less than or 1
	if (A.indexOf(onlyTestArr, element.name) != -1 || A.compact(onlyTestArr).count() == 0) {
		fileAppend, % newline "assert.group(""." element.name """)", % testsFilePath
		fileAppend, % newline "assert.label(""default tests"")", % testsFilePath
		fileAppend, % element.tests "", % testsFilePath
	}
}
fileAppend, %test_tail%, % testsFilePath

; ===============
; method names
; ===============
loop, % dataArr.count() {
	element := dataArr[A_Index]
	methodNamesArr.push(element.name)
}
; put all method names on the clipboard
if (devOptions.clipboardMethods) {
	clipboard := A.join(methodNamesArr, "|")
}

; msgbox all the methods not completed yet
if (devOptions.msgboxMissingMethods) {
	msgbox, % A.join(A.difference(A.castArray(lodashMethodNamesArr), methodNamesArr), ", ")
}


; ===============
; DOCS
; ===============
fileDelete, % readmeFilePath
docsArr := [fn_readFile(A_WorkingDir "\src\_head.tail\doc_head.md")]

loop, % dataArr.count() {
	element := dataArr[A_Index]
	if (A.indexof(ignoreMethodDocsArr, element.name) != -1 || A.startsWith(element.name, "internal")) { ; skip ignored methods
		continue
	}
	; skip if category is any of the following
	if (A.isMatch(element, {"category": "external"}) || A.isMatch(element, {"category": "internal"})) {
		continue
	}

	txt := []
	exampleArray := []
	if (element.category != dataArr[A_Index - 1].category) {
		txt.push(newline "# **" A.startCase(element.category) " methods**" newline)
	}
	txt.push("## " "." element.name newline newline)
	txt.push("<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/" element.category "/" element.name ".ahk' class='text-muted'>source</a>")
	txt.push(newline newline element.doc newline newline)
	; if examples not staticly defined in .md file, parse tests for use in documentation
	if (!A.includes(element.doc,"Example") && A.includes(element.tests, settings.objectName ".")) {
		txt.push("#### Example" newline newline "``````autohotkey" newline)
		exampleArray := fn_buildExample(strSplit(element.tests, "`n"))
		exampleArray.push("``````" newline newline)
		txt := A.concat(txt,exampleArray)
	}
	txt.push(newline newline)
	docsArr := A.concat(docsArr, txt)
}
loop, % docsArr.count() {
	fileAppend, % docsArr[A_Index], % readmeFilePath
}



; ===============
; LIBRARY EXPORT
; ===============
for _, value in dataArr {
	for _, alias in aliasMap[value.name] {
		newElement := {}
		newElement := A.cloneDeep(value)
		newElement.name := alias
		newElement.lib := A.replace(newElement.lib, value.name, alias)
		dataArr.push(newElement)
	}
}

; add indentation to library
lib_array := A.map(dataArr, Func("fn_AddIndent"))
; fn_AddMark(value) {
; 	value.lib := A_Tab ";MARK: ." value.name "`n" value.lib
; 	return value
; }
fn_AddIndent(value) {
	x := biga.replace(value.lib,"/m)^(.+)/", A_Tab "$1")
	x := biga.replace(x, "/m`n)^([\s\n\r]*)$/","")
	x := biga.replace(x, "/m`n)(^[\s\n\r]*$)/","")
	return x
}

fileDelete, % libraryFilePath
lib_head := A.split(fn_readFile(A_WorkingDir "\src\_head.tail\lib_head.ahk"), "`n")
lib_tail := A.split(fn_readFile(A_WorkingDir "\src\_head.tail\lib_tail.ahk"), "`n")
lib_txt := A.join(A.concat(lib_head, lib_array, lib_tail), "")
; blank out commented sections from lib_txt
; lib_txt := A.replace(lib_txt,"/(^\s*;(?:.*))(?:\r?\n\g<1>)+/","")
while (regExMatch(lib_txt, "Om)^(\h*;.*)(?:\R\g<1>){3,}", RE_Match)) {
	lib_txt := A.replace(lib_txt, RE_Match.value(), "")
}
; remove blank lines
; lib_txt := A.replace(lib_txt, "/([`r`n]+)/","`r`n")
fileAppend, % lib_txt, % libraryFilePath

; === GLOBAL TESTS worth throwing a huge error===
if (A.includes(lib_txt, "/\s*max\(\d+\,\s*\d+/")) {
	throw "Max() appears - script should NOT contain max() as it requires later ahk version"
}

; print any dev messages
if (A.size(msgArr)) {
	A.print(A.join(msgArr, "`n`n"))
}

sleep, 100
run, % testsFilePath
exitApp, 1




; /--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
; functions
; \--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/


fn_buildExample(param_tests) {
	global
	; Input - > array containing `n separated textfile of assert.{{x}} tests
	; Output - > array suitable for export to markdown
	returnArr := []

	for key, value in param_tests {
		; stop parsing if omit section reached
		if (biga.includes(value, "; omit")) {
			break
		}
		; skip this line if part of assert.label
		if (biga.includes(value, "assert.label")) {
			continue
		}

		line := Fn_QuickRegEx(value, testtest, 0)
		if (line.count() = 2) {
			returnArr.push(line.value(1) "`n; => " line.value(2) newline newline)
			continue
		}
		line := Fn_QuickRegEx(value, testnotequal, 0)
		if (line.count() = 2) {
			returnArr.push(line.value(1) "`n; => " line.value(2) newline newline)
			continue
		}
		line := Fn_QuickRegEx(value, testtrue, 0)
		if (line.count() = 2) {
			returnArr.push(line.value(1) line.value(2) "`n; => true" newline newline)
			continue
		}
		line := Fn_QuickRegEx(value, testfalse, 0)
		if (line.count() = 2) {
			returnArr.push(line.value(1) line.value(2)"`n; => false" newline newline)
			continue
		}

		; if the line has no changes needed
		if (biga.size(value) > 1) {
			returnArr.push(value)
		}
	}
	return returnArr
}

fn_readFile(param_fileToRead) {
	fileRead, l_MemoryFile, % param_fileToRead
	return l_MemoryFile
}
