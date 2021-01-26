omit(param_object,param_paths) {
	if (!IsObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	l_obj := this.cloneDeep(param_object)

	; create
	if (IsObject(param_paths)) {
		for Key, Value in param_paths {
			l_obj.delete(Value)
		}
	} else {
		l_obj.delete(param_paths)
	}
	return  l_obj
}


; tests
object := {"a": 1, "b": "2", "c": 3}
assert.test(A.omit(object, ["a", "c"]), {"b": "2"})


; omit
assert.test(A.omit(object, "a"), {"b": "2", "c": 3})
