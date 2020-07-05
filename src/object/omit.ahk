omit(param_object,param_paths) {
	if (!IsObject(param_object)) {
		this.internal_ThrowException()
	}

	; data setup
	l_obj := this.cloneDeep(param_object)
	
	; create
	if (IsObject(param_paths)) {
		for Key, Value in param_paths {
            l_obj.Delete(Value)
		}
	} else {
		l_obj.Delete(param_paths)
	}
	return  l_obj
}


; tests
object := {"a": 1, "b": "2", "c": 3}
assert.test(A.omit(object, ["a", "c"]), {"b": "2"})


; omit
assert.test(A.omit(object, "a"), {"b": "2", "c": 3})
