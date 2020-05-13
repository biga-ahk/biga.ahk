add(param_augend,param_addend) {
	if (IsObject(param_augend) || IsObject(param_addend)) {
		this.internal_ThrowException()
	}

	; create the return
	param_augend += param_addend
	return param_augend
}


; tests
assert.test(A.add(6, 4), 10)


; omit
assert.test(A.add(10, -1), 9)
assert.test(A.add(-10, -10), -20)
assert.test(A.add(10, 0.01), 10.01)
