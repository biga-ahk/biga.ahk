last(param_array) {

	; prepare
	if (isObject(param_array)) {
		param_array := this.clone(param_array)
	}
	if (this.isStringLike(param_array)) {
		param_array := strSplit(param_array)
	}

	; create
	return param_array.pop()
}


; tests
assert.test(A.last([1, 2, 3]), 3)
assert.test(A.last([]), "")
assert.test(A.last("fred"), "d")
assert.test(A.last(100), "0")


; omit
assert.label("no mutations")
array := [1, 2, "hey"]
assert.test(A.last(array), "hey")
assert.test(array.count(), 3)
