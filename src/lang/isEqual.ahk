isEqual(param_value,param_other*) {

	; prepare
	if (isObject(param_value)) {
		l_array := []
		param_value := this._internal_stringify(param_value)
		loop, % param_other.count() {
			l_array.push(this._internal_stringify(param_other[A_Index]))
		}
	} else {
		l_array := this.cloneDeep(param_other)
	}

	; create
	loop, % l_array.count() {
		if (param_value != l_array[A_Index]) { ; != follows StringCaseSense
			return false
		}
	}
	return true
}


; tests
assert.true(A.isEqual(1, 1))
assert.true(A.isEqual({ "a": 1 }, { "a": 1 }))
assert.false(A.isEqual(1, 1, 2))
StringCaseSense, On
assert.false(A.isEqual({ "a": "a" }, { "a": "A" }))


; omit
StringCaseSense, Off
assert.false(A.isEqual({ "a": 1 }, { "a": 2 }))

assert.label("variadric parameters")
assert.true(A.isEqual(1, 1, 1))
assert.true(A.isEqual({ "a": 1 }, { "a": 1 }, { "a": 1 }))
assert.false(A.isEqual(1, 1, { "a": 1 }))

assert.label("leading zero numbers")
assert.true(A.isEqual(00011, 11))
assert.true(A.isEqual(011, 11))
assert.true(A.isEqual(11, 11))

assert.label("decimal places")
assert.true(A.isEqual(1.0, 1.000))
assert.true(A.isEqual(11, 11.000))
assert.false(A.isEqual(11, 11.0000000001))

assert.label("string comparison")
assert.true(A.isEqual(11, "11"))
assert.true(A.isEqual("11", "11"))

assert.label("empty string")
assert.true(A.isEqual({}, {}))

assert.label("different keys")
assert.false(A.isEqual({"a": 1}, {"b": 1}))
assert.false(A.isEqual({"a": 1}, [1]))
