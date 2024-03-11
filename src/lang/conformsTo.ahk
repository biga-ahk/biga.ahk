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

assert.true(A.conformsTo(object, {"b": func("fn_conformsToFunc1")}))
assert.false(A.conformsTo(object, {"b": func("fn_conformsToFunc2")}))

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
assert.true(A.conformsTo(object, {"b": func("fn_conformsToFunc1"), "c": func("fn_conformsToFunc1")}))

assert.label("Testing with a different object")
assert.true(A.conformsTo({"a": 3, "b": 4}, {"b": func("fn_conformsToFunc1")}))

assert.label("Testing with an extra key in the object")
assert.true(A.conformsTo({"a": 1, "b": 2, "c": 3}, {"b": func("fn_conformsToFunc1")}))

assert.label("Testing with a missing key in the object")
assert.false(A.conformsTo({"a": 1}, {"b": func("fn_conformsToFunc1")}))

assert.label("Testing with an empty object")
assert.false(A.conformsTo({}, {"b": func("fn_conformsToFunc1")}))
