conformsTo(param_object, param_source) {
	if (!isObject(param_object) || !isObject(param_source)) {
		this._internal_ThrowException()
	}

	; create
	for key, value in param_source {
		if (!value.call(param_object[key])) {
			return false
		}
	}
	return true
}


; tests
object := {"a": 1, "b": 2}

assert.true(A.conformsTo(object, {"b": Func("fn_conformsToFunc1")}))
assert.false(A.conformsTo(object, {"b": Func("fn_conformsToFunc2")}))

fn_conformsToFunc1(n)
{
	return n > 1
}

fn_conformsToFunc2(n)
{
	return n > 2
}

; omit
object := {"a": 1, "b": 2, "c": 2}
assert.true(A.conformsTo(object, {"b": Func("fn_conformsToFunc1"), "c": Func("fn_conformsToFunc1")}))
