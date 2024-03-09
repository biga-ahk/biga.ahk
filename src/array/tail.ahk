tail(param_array) {

	; create
	return this.drop(param_array)
}


; tests
assert.test(A.tail([1, 2, 3]), [2, 3])
assert.test(A.tail("fred"), ["r", "e", "d"])
assert.test(A.tail(100), ["0", "0"])

; omit
assert.test(A.tail([]), [])
assert.label("Array with a single element")
assert.test(A.tail([1]), [])

assert.label("Array with two elements")
assert.test(A.tail([1, 2]), [2])

assert.label("Array with multiple elements")
assert.test(A.tail([1, 2, 3, 4]), [2, 3, 4])

assert.label("String with a single character")
assert.test(A.tail("f"), [])

assert.label("String with two characters")
assert.test(A.tail("fe"), ["e"])

assert.label("String with multiple characters")
assert.test(A.tail("fred"), ["r", "e", "d"])

assert.label("Number input")
assert.test(A.tail(100), ["0", "0"])
