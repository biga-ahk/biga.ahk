pickBy(param_object,param_predicate:="__identity") {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_detectShorthand(param_predicate, param_collection)
	if (shorthand) {
		param_predicate := this._internal_createShorthandfn(param_predicate, param_collection)
	}
	l_obj := {}

	; create
	for key, value in param_object {
		if (this.isFunction(param_predicate)) {
			if (!this.isFalsey(param_predicate.call(value, key))) {
				l_obj[key] := value
			}
		}
	}
	return l_obj
}


; tests
object := {"a": 1, "b": "two", "c": 3}
assert.test(A.pickBy(object, A.isNumber), {"a": 1, "c": 3})


; omit
assert.label("default .identity argument")
assert.test(A.pickBy([0, 1, 2]), {"2": 1, "3": 2})

object := {"a": 1, "b": "two", "c": 3}
assert.test(A.pickBy(object, A.isString), {"b": "two"})

assert.label("custom predicate function")
fn_pickBy(value, key) {
	if (key = "a" || key = "c") {
		return true
	}
	return false
}
assert.test(A.pickBy(object, func("fn_pickBy")), {"a": 1, "c": 3})
