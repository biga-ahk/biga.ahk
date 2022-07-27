eq(param_value, param_other) {

	; prepare
	if (isObject(param_value)) {
		param_value := this._internal_stringify(param_value)
		param_other := this._internal_stringify(param_other)
	}

	; create
	if (param_value == param_other) {
		return true
	}
	return false
}


; tests
object := {"a": 1}
other := {"a": 1}

assert.true(A.eq(object, other))
assert.true(A.eq("a", "a"))
assert.true(A.eq("", ""))

; omit
