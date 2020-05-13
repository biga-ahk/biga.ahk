defaults(param_object,param_sources*) {
	if (!IsObject(param_object)) {
		this.internal_ThrowException()
	}

	; data setup
	l_obj := this.clone(param_object)
	param_sources := this.reverse(param_sources)
	
	; create
	for Index, Object in param_sources {
		for Key, Value in Object {
			if (!l_obj.HasKey(Key)) { ; if the key is not already in use
				l_obj[Key] := Value
			}
		}
	}
	return l_obj
}


; tests
assert.test(A.defaults({"a": 1}, {"b": 2}, {"a": 3}), {"a": 1, "b": 2})


; omit
object := {"a": 1}
assert.test(A.defaults(object, {"b": 2, "c": 3}), {"a": 1, "b": 2, "c": 3})
assert.test(object, {"a": 1})
