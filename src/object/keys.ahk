keys(param_object) {

	; prepare
	if (!isObject(param_object)) {
		param_object := strSplit(param_object)
	}
	l_returnkeys := []

	; create
	for key, _ in param_object {
		l_returnkeys.push(key)
	}
	return l_returnkeys
}


; tests
object := {"a": 1, "b": 2, "c": 3}
assert.test(A.keys(object), ["a", "b", "c"])

assert.test(A.keys("hi"), [1, 2])


; omit
