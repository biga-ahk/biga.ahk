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
assert.label("different object")
assert.false(A.eq({"a": 2}, {"a": 1}))

assert.label("different string")
assert.false(A.eq("b", "a"))

assert.label("different empty string")
assert.false(A.eq(" ", ""))

assert.label("number")
assert.true(A.eq(1, 1))

assert.label("different number")
assert.false(A.eq(2, 1))

assert.label("boolean")
assert.true(A.eq(true, true))

assert.label("different boolean")
assert.false(A.eq(true, false))

assert.label("Testing with undefined values")
assert.true(A.eq("", ""))
