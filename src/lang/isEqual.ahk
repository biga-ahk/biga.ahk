isEqual(param_value,param_other) {
	if (IsObject(param_value)) {
		param_value := this._printObj(param_value)
		param_other := this._printObj(param_other)
	}

	return !(param_value != param_other) ; != follows StringCaseSense
}


; tests
assert.true(A.isEqual(1, 1))
assert.true(A.isEqual({ "a": 1 }, { "a": 1 }))
assert.false(A.isEqual(1, 2))
StringCaseSense, On
assert.false(A.isEqual({ "a": "a" }, { "a": "A" }))


; omit
StringCaseSense, Off
assert.false(A.isEqual({ "a": 1 }, { "a": 2 }))
