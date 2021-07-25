pick(param_object,param_paths) {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	l_obj := {}

	; create
	if (isObject(param_paths)) {
		for key, value in param_paths {
			vValue := this.internal_property(value, param_object)
			l_obj[value] := vValue
		}
	} else {
		vValue := this.internal_property(param_paths, param_object)
		l_obj[param_paths] := vValue
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
