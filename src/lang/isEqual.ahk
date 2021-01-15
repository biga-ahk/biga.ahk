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
	if (this.isNumber(param_value)) {
		loop, % l_array.Count() {
			if (this.isFloat(param_value) || this.isFloat(l_array[A_Index])) {
				value := this.parseInt(param_value)
				comparison := this.parseInt(l_array[A_Index])
			} else {
				value := this._internal_MD5(param_value)
				comparison := this._internal_MD5(l_array[A_Index])
			}
			if (value != comparison) {
				return false
			}
		}
		return true
	}
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

assert.label(".isEqual - leading zero numbers")
assert.false(A.isEqual(00011, 11))
assert.true(A.isEqual(11, 11))

assert.label(".isEqual - decimal places")
assert.true(A.isEqual(1.0, 1.000))
assert.true(A.isEqual(11, 11.000))
