; /--\--/--\--/--\--/--\--/--\
; Internal functions
; \--/--\--/--\--/--\--/--\--/



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
	if (!this.isString(param_string) && !this.isAlnum(param_string)) {
		this._internal_ThrowException()
	}
	if (this.startsWith(param_string, "/") && this.endsWith(param_string, "/")) {
		return SubStr(param_string, 2, StrLen(param_string) - 2)
	}
	return false
}


_internal_differenciateShorthand(param_shorthand,param_objects:="") {
	if (this.startsWith(param_shorthand.name, this.base.__Class ".")) { ;if starts with "biga."
		return "_classMethod"
	}
	if (isObject(param_shorthand) && !this.isFunction(param_shorthand)) {
		if (param_shorthand.maxIndex() != param_shorthand.count()) {
			return ".matches"
		}
		return ".matchesProperty"
	}
	if (this.isStringLike(param_shorthand) && isObject(param_objects)) {
		for key, value in param_objects {
			if (value.hasKey(param_shorthand)) {
				return ".property"
			}
		}
	}
	if (param_shorthand == "__identity") {
		return "__identity"
	}
	return false
}


_internal_createShorthandfn(param_shorthand,param_objects:="") {
	shorthand := this._internal_differenciateShorthand(param_shorthand, param_objects)
	if (shorthand == "_classMethod") {
		return param_shorthand.bind(this)
	}
	if (shorthand == ".matches") {
		return this.matches(param_shorthand)
	}
	if (shorthand == ".matchesProperty") {
		return this.matchesProperty(param_shorthand[1], param_shorthand[2])
	}
	if (shorthand == ".property") {
		return this.property(param_shorthand)
	}
	if (param_shorthand == "__identity") {
		boundFunc := objBindMethod(this, "identity")
		return boundFunc
	}
}


_internal_ThrowException() {
	if (this.throwExceptions == true) {
		throw Exception("Type Error", -2)
	}
}

_internal_inStr(param_haystack,param_needle,param_fromIndex:=1,param_occurance:=1) {
	; used inplace of inStr to follow A_StringCaseSense
	if (A_StringCaseSense == "On") {
		StringCaseSense := 1
	} else {
		StringCaseSense := 0
	}
	if (position := inStr(param_collection, param_value, StringCaseSense, param_fromIndex, param_occurance)) {
		return position
	} else {
		return false
	}
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
isStringLike(param) {
	if (isObject(param)) {
		return false
	}
	if (this.isString(param) || this.isAlnum(param)) {
		return true
	}
	return false
}

; tests
assert.label("_internal_JSRegEx")
assert.test(A._internal_JSRegEx("/RegEx(capture)/"),"RegEx(capture)")

assert.label("md5")
assert.notEqual(A._internal_MD5({"a": [1,2,[3]]}), A._internal_MD5({"a": [1,2,[99]]}))

assert.label("isFalsey")
assert.true(A.isFalsey(0))
assert.true(A.isFalsey(""))
assert.false(A.isFalsey([]))
assert.false(A.isFalsey({}))

; omit
