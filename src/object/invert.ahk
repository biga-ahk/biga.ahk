invert(param_object) {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	l_obj := this.cloneDeep(param_object)
	l_newObj := {}

	; create
	for key, value in l_obj {
		l_newObj[value] := key
	}
	return l_newObj
}


; tests
object := {"a": 1, "b": 2, "c": 1}
assert.test(A.invert(object), {"1": "c", "2": "b"})

assert.test(A.invert({1: "a", 2: "A"}), {"a": 2})


; omit
assert.label("do not mutate")
object := {"a": 1}
assert.test(A.invert(object), {"1": "a"})
assert.test(object, {"a": 1})

assert.label("blank object")
assert.test(A.invert({}), {})
