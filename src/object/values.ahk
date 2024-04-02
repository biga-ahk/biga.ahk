values(param_object) {

	; prepare
	l_array := []
	if (this.isStringLike(param_object)) {
		param_object := strSplit(param_object)
	}

	; create
	for key, value in param_object {
		l_array.push(value)
	}
	return l_array
}


; tests
object := {"a": 1, "b": 2}
object.c := 3

assert.test(A.values(object), [1, 2, 3])
assert.test(A.values("hi"), ["h", "i"])

; omit
