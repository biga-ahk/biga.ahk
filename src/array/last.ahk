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

assert.label("Array with last element as array")
assert.test(A.last([1, 2, [3, 4]]), [3, 4])

assert.label("Array with last element as associative array")
assert.test(A.last([1, {"a": 1, "b": 2}]), {"a": 1, "b": 2})

assert.label("Array with last element as empty associative array")
assert.test(A.last([1, {}]), {})

assert.label("String with last character as whitespace")
assert.test(A.last("Hello "), " ")

assert.label("String with last character as special character")
assert.test(A.last("Hello!"), "!")

assert.label("String with last character as number")
assert.test(A.last("12345"), "5")

assert.label("String with last character as special symbol")
assert.test(A.last("Hello$"), "$")

assert.label("Number with multiple digits")
assert.test(A.last(12345), "5")
