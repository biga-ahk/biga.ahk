zipObject(param_props,param_values) {
	if (!isObject(param_props)) {
		param_props := []
	}
	if (!isObject(param_values)) {
		param_values := []
	}

	l_obj := {}
	for key, value in param_props {
		l_obj[value] := param_values[A_Index]
	}
	return l_obj
}


; tests
assert.test(A.zipObject(["a", "b"], [1, 2]), {"a": 1, "b": 2})


; omit
assert.test(A.zipObject(["a", "b", "c"], [1, 2]), {"a": 1, "b": 2, "c": ""})
