pick(param_object,param_paths) {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	l_obj := {}

	; create
	if (isObject(param_paths)) {
		for key, value in param_paths {
			l_obj[value] := this.get(param_object, value)
		}
	} else {
		l_deepPath := this.toPath(param_paths)
		l_obj[l_deepPath*] := param_object[l_deepPath*]
	}
	return l_obj
}


; tests
object := {"a": 1, "b": "2", "c": 3}
assert.test(A.pick(object, ["a", "c"]), {"a": 1, "c": 3})


; omit
assert.test(A.pick(object, "a"), {"a": 1})
assert.test(A.pick({ "a": {"b": 2}}, "a"), { "a": {"b": 2}})
; assert.test(A.pick({ "a": {"b": 2}}, "a.b"), {"a": {"b": 2}})
