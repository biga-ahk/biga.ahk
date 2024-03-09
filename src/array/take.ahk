take(param_array,param_n:=1) {
	if (!this.isNumber(param_n)) {
		this._internal_ThrowException()
	}

	; prepare
	if (isObject(param_array)) {
		param_array := this.clone(param_array)
	}
	if (this.isStringLike(param_array)) {
		param_array := strSplit(param_array)
	}
	l_array := []

	; create
	for key, value in param_array {
		if (param_n < A_Index) {
			break
		}
		l_array.push(value)
	}
	; return empty array if empty
	if (l_array.count() == 0 || param_n == 0) {
		return []
	}
	return l_array
}


; tests
assert.test(A.take([1, 2, 3]), [1])
assert.test(A.take([1, 2, 3], 2), [1, 2])
assert.test(A.take([1, 2, 3], 5), [1, 2, 3])
assert.test(A.take([1, 2, 3], 0), [])
assert.test(A.take("fred"), ["f"])
assert.test(A.take(100), ["1"])
; omit
assert.label("Empty array input")
assert.test(A.take([]), [])

assert.label("Array with a single element")
assert.test(A.take([1], 1), [1])

assert.label("Array with two elements")
assert.test(A.take([1, 2], 1), [1])

assert.label("Array with multiple elements")
assert.test(A.take([1, 2, 3, 4], 3), [1, 2, 3])

assert.label("String with a single character")
assert.test(A.take("f", 1), ["f"])

assert.label("String with two characters")
assert.test(A.take("fe", 1), ["f"])

assert.label("String with multiple characters")
assert.test(A.take("fred", 2), ["f", "r"])

assert.label("Number")
assert.test(A.take(100, 1), ["1"])
