print(values*) {
	for key, value in values {
		out .= (IsObject(value) ? this._internal_stringify(value) : value)
	}
	try {
		DllCall("AttachConsole", "int", -1)
		FileAppend, % "`n" out, CONOUT$
		DllCall("FreeConsole")
	} catch {

	}
	return out
}

_internal_stringify(param_value) {
	if (!isObject(param_value)) {
		return """" param_value """"
	}
	for key, value in param_value {
		if key is not Number
		{
			output .= """" . key . """:"
		} else {
			output .= key . ":"
		}
		if (isObject(value)) {
			output .= "[" . this._internal_stringify(value) . "]"
		} else if value is not number
		{
			output .= """" . value . """"
		} else {
			output .= value
		}
		output .= ", "
	}
	return subStr(output, 1, -2)
}


; tests
assert.test(A.print([1, 2, 3]), "1:1, 2:2, 3:3")

; omit
assert.test(A.print("hello ", "world ", [1, 2, 3]), "hello world 1:1, 2:2, 3:3")
