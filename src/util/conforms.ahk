conforms(param_value) {
	if (!isObject(param_value)) {
		this._internal_ThrowException()
	}

	boundFunc := ObjBindMethod(this, "_internal_conforms", param_value)
	return boundFunc
}

_internal_conforms(param_value, param_object) {
	for key, value in param_value {
		if (!value.call(param_object[key])) {
			return false
		}
	}
	return true
}


; tests
objects := [{"a": 2, "b": 1}
		, {"a": 1, "b": 2}]
assert.test(A.filter(objects, A.conforms({"b": Func("fn_conformsFunc1")})), [{"a": 1, "b": 2}])

fn_conformsFunc1(n)
{
	return n > 1
}

; omit
