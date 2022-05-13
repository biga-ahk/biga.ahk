typeOf(param_value:="__default") {
	if (isObject(param_value)) {
		return "object"
	}
	if (param_value == "") {
		return "undefined"
	}
	if param_value is float
	{
		return "float"
	}
	return param_value := "" || [param_value].GetCapacity(1) ? "string" : "integer"
}


; tests
assert.test(A.typeOf(42), "integer")
assert.test(A.typeOf(0.25), "float")
assert.test(A.typeOf("blubber"), "string")
assert.test(A.typeOf([]), "object")
assert.test(A.typeOf(undeclaredVariable), "undefined")

; omit
; fix to string if ever possible
assert.test(A.typeOf("0.25"), "float") ;

; ahk `true` is indistinguishable from `1`, etc
; assert.test(A.typeOf(true), "boolean")
