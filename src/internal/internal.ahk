; /--\--/--\--/--\--/--\--/--\
; Internal functions
; \--/--\--/--\--/--\--/--\--/

_printObj(param_obj) {
	if (!isObject(param_obj)) {
		return """" param_obj """"
	}
	if this._internal_IsCircle(param_obj) {
		this._internal_ThrowException()
	}

	for Key, Value in param_obj {
		if Key is not Number
		{
			Output .= """" . Key . """:"
		} else {
			Output .= Key . ":"
		}
		if (isObject(Value)) {
			Output .= "[" . this._printObj(Value) . "]"
		} else if Value is not number
		{
			Output .= """" . Value . """"
		} else {
			Output .= Value
		}
		Output .= ", "
	}
	StringTrimRight, OutPut, OutPut, 2
	return OutPut
}
print(param_obj) {
	if (!isObject(param_obj)) {
		return """" param_obj """"
	}
	if this._internal_IsCircle(param_obj) {
		this._internal_ThrowException()
	}

	return this._printObj(param_obj)
}


_internal_MD5(param_string, case := 0) {
	if (isObject(param_string)) {
		param_string := this.print(param_string)
	}
	static MD5_DIGEST_LENGTH := 16
	hModule := DllCall("LoadLibrary", "Str", "advapi32.dll", "Ptr")
	, VarSetCapacity(MD5_CTX, 104, 0), DllCall("advapi32\MD5Init", "Ptr", &MD5_CTX)
	, DllCall("advapi32\MD5Update", "Ptr", &MD5_CTX, "AStr", param_string, "UInt", StrLen(param_string))
	, DllCall("advapi32\MD5Final", "Ptr", &MD5_CTX)
	loop % MD5_DIGEST_LENGTH {
		o .= Format("{:02" (case ? "X" : "x") "}", NumGet(MD5_CTX, 87 + A_Index, "UChar"))
	}
	DllCall("FreeLibrary", "Ptr", hModule)
	return o
}


_internal_JSRegEx(param_string) {
	if (this.startsWith(param_string, "/") && this.startsWith(param_string, "/", StrLen(param_string))) {
		return SubStr(param_string, 2, StrLen(param_string) - 2)
	}
	return false
}


_internal_differenciateShorthand(param_shorthand,param_objects:="") {
	if (isObject(param_shorthand)) {
		for Key, in param_shorthand {
			if (this.isNumber(Key)) {
				continue
			} else {
				return ".matches"
			}
		}
		return ".matchesProperty"
	}
	if (this.size(param_shorthand) > 0) {
		if (isObject(param_objects)) {
			if (param_objects[1][param_shorthand] != "") {
				return ".property"
			}
		}
	}
	return false
}


_internal_createShorthandfn(param_shorthand,param_objects) {
	shorthand := this._internal_differenciateShorthand(param_shorthand, param_objects)
	if (shorthand == ".matches") {
		return this.matches(param_shorthand)
	}
	if (shorthand == ".matchesProperty") {
		return this.matchesProperty(param_shorthand[1], param_shorthand[2])
	}
	if (shorthand == ".property") {
		return this.property(param_shorthand)
	}
}


_internal_ThrowException() {
	if (this.throwExceptions == true) {
		throw Exception("Type Error", -2)
	}
}


isAlnum(param) {
	if (isObject(param)) {
		return false
	}
	if param is alnum
	{
		return true
	}
	return false
}

isString(param) {
	if (isObject(param)) {
		return false
	}
	if param is alnum
	{
		return true
	}
	if (strLen(param) > 0) {
		return true
	}
	return false
}


isNumber(param) {
	if (isObject(param)) {
		return false
	}
	if param is number
	{
		return true
	}
	return false
}

isFloat(param) {
	if (isObject(param)) {
		return false
	}
	if param is float
	{
		return true
	}
	return false
}


isFalsey(param) {
	if (isObject(param)) {
		return false
	}
	if (param == "" || param == 0) {
		return true
	}
	return false
}


; tests
assert.label("_internal_JSRegEx")
assert.test(A._internal_JSRegEx("/RegEx(capture)/"),"RegEx(capture)")

assert.label("md5")
assert.notEqual(A._internal_MD5({"a": [1,2,[3]]}), A._internal_MD5({"a": [1,2,[99]]}))

assert.label("type checking")
assert.true(A.isAlnum(1))
assert.true(A.isAlnum("hello"))
assert.false(A.isAlnum([]))
assert.false(A.isAlnum({}))

assert.true(A.isNumber(1))
assert.true(A.isNumber("1"))
assert.false(A.isNumber([]))
assert.false(A.isNumber({}))

assert.true(A.isFalsey(0))
assert.true(A.isFalsey(""))
assert.false(A.isFalsey([]))
assert.false(A.isFalsey({}))

; omit
