defaults(param_object,param_sources*) {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	l_obj := this.clone(param_object)
	param_sources := this.reverse(param_sources)

	; create
	for index, object in param_sources {
		for key, value in object {
			; write if the key is not already in use
			if (!l_obj.hasKey(key)) {
				l_obj[key] := value
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
