takeRight(param_array,param_n:=1) {
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
	loop, % param_n	{
		if (param_array.count() == 0) {
			break
		}
		vvalue := param_array.pop()
		l_array.push(vvalue)
	}
	; return empty array if empty
	if (l_array.count() == 0 || param_n == 0) {
		return []
	}
	return this.reverse(l_array)
}


; tests
assert.test(A.takeRight([1, 2, 3]), [3])
assert.test(A.takeRight([1, 2, 3], 2), [2, 3])
assert.test(A.takeRight([1, 2, 3], 5), [1, 2, 3])
assert.test(A.takeRight([1, 2, 3], 0), [])
assert.test(A.takeRight("fred"), ["d"])
assert.test(A.takeRight(100), ["0"])

; omit
assert.test(A.takeRight([]), [])
assert.test(A.takeRight("fred", 3), ["r","e","d"])

assert.label("mutation")
string := "fred"
assert.test(A.takeRight(string, 4), ["f","r","e","d"])
assert.test(string, "fred")

obj := [1, 2, 3]
assert.test(A.takeRight(obj), [3])
assert.test(obj, [1, 2, 3])

assert.label("Array with a single element")
assert.test(A.takeRight([1], 1), [1])

assert.label("Array with two elements")
assert.test(A.takeRight([1, 2], 1), [2])

assert.label("Array with multiple elements")
assert.test(A.takeRight([1, 2, 3, 4], 2), [3, 4])

assert.label("String with a single character")
assert.test(A.takeRight("f", 1), ["f"])

assert.label("String with two characters")
assert.test(A.takeRight("fe", 1), ["e"])

assert.label("String with multiple characters")
assert.test(A.takeRight("fred", 2), ["e", "d"])

assert.label("Number input")
assert.test(A.takeRight(100, 1), ["0"])
