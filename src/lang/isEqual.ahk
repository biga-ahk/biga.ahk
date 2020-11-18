isEqual(param_value,param_other*) {

	; prepare
	if (IsObject(param_value)) {
		l_array := []
		param_value := this._printObj(param_value)
		loop, % param_other.Count() {
			l_array.push(this._printObj(param_other[A_Index]))
		}
	} else {
		l_array := this.cloneDeep(param_other)
	}

	; create
	loop, % l_array.Count() {
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

assert.label(".isEqual - variadric parameters")
assert.true(A.isEqual(1, 1, 1))
assert.true(A.isEqual({ "a": 1 }, { "a": 1 }, { "a": 1 }))
assert.false(A.isEqual(1, 1, { "a": 1 }))
