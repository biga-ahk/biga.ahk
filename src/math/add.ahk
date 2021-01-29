add(param_augend,param_addend) {
	if (!this.isNumber(param_augend) || !this.isNumber(param_addend)) {
		this._internal_ThrowException()
	}

	; create
	return param_augend + param_addend
}


; tests
assert.test(A.add(6, 4), 10)


; omit
assert.test(A.add(10, -1), 9)
assert.test(A.add(-10, -10), -20)
assert.test(A.add(10, 0.01), 10.01)

assert.label("parameter mutation")
value := 10
A.add(value, 10)
assert.test(value, 10)