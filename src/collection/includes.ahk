includes(param_collection,param_value,param_fromIndex:=1) {
	if (!this.isNumber(param_fromIndex)) {
		this._internal_ThrowException()
	}

	; prepare
	if (isObject(param_value)) {
		param_value := this._internal_MD5(param_value)
		param_collection := this.map(param_collection, this._internal_MD5)
	}

	; create
	if (isObject(param_collection)) {
		for key, value in param_collection {
			if (param_fromIndex > A_Index) {
				continue
			}
			if (this.isEqual(value, param_value)) {
				return true
			}
		}
		return false
	} else {
		; RegEx
		if (RegEx_value := this._internal_JSRegEx(param_value)) {
			return RegExMatch(param_collection, RegEx_value, RE, param_fromIndex)
		}
		; Normal string search
		if (A_StringCaseSense == "On") {
			StringCaseSense := 1
		} else {
			StringCaseSense := 0
		}
		if (InStr(param_collection, param_value, StringCaseSense, param_fromIndex)) {
			return true
		} else {
			return false
		}
	}
}


; tests
assert.true(A.includes([1, 2, 3], 1))
assert.true(A.includes({ "a": 1, "b": 2 }, 1))
assert.true(A.includes("InStr", "Str"))
StringCaseSense, On
assert.false(A.includes("InStr", "str"))
; RegEx object
assert.true(A.includes("hello!", "/\D/"))


; omit
StringCaseSense, Off
assert.false(A.includes("InStr", "Other"))
assert.label("object search")
assert.true(A.includes([[1], [2]], [2]))
