print(values*) {
	for key, value in values {
		out .= (isObject(value) ? this._internal_stringify(value) : value)
	}
	try {
		dllCall("AttachConsole", "int", -1)
		fileAppend, % "`n" out, CONOUT$
		dllCall("FreeConsole")
	} catch {

	}
	return out
}

; tests
assert.test(A.print([1, 2, 3]), "1:1, 2:2, 3:3")

; omit
assert.test(A.print("object: ", [1, 2, 3]), "object: 1:1, 2:2, 3:3")
assert.test(A.print("hello ", "world ", [1, 2, 3]), "hello world 1:1, 2:2, 3:3")
