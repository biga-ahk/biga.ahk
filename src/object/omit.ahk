omit(param_object,param_paths) {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	l_obj := this.cloneDeep(param_object)

	; create
	if (isObject(param_paths)) {
		for key, value in param_paths {
			l_obj.delete(value)
		}
	} else {
		l_obj.delete(param_paths)
	}
	return l_obj
}


; tests
object := {"a": 1, "b": "2", "c": 3}
assert.test(A.omit(object, ["a", "c"]), {"b": "2"})


; omit
assert.test(A.omit(object, "a"), {"b": "2", "c": 3})
