keys(param_object) {

	; prepare
	if (!isObject(param_object)) {
		param_object := StrSplit(param_object)
	}
	l_returnKeys := []

	; create
	for key, _ in param_object {
		l_returnKeys.push(key)
	}
	return l_returnKeys
}


; tests
object := {"a": 1, "b": 2, "c": 3}
assert.test(A.keys(object), ["a", "b", "c"])

assert.test(A.keys("hi"), [1, 2])


; omit
