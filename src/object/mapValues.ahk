mapValues(param_object,param_iteratee:="__identity") {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_iteratee, param_object)
	if (shorthand) {
		param_iteratee := this._internal_createShorthandfn(param_iteratee, param_object)
	}
	l_object := this.cloneDeep(param_object)
	l_array := {}

	; create
	for key, value in l_object {
		; functor
		if (this.isFunction(param_iteratee)) {
			l_array[key] := param_iteratee.call(value, key, l_object)
		}
	}
	return l_array
}


; tests
users := {"fred": {"user": "fred", "age": 40}
		,"pebbles": {"user": "pebbles", "age": 1}}
assert.test(A.mapValues(users, Func("fn_mapValuesFunc")), {"fred": 40, "pebbles": 1})
fn_mapValuesFunc(o)
{
	return o.age
}

; The A.property iteratee shorthand.
assert.test(A.mapValues(users, "age"), {"fred": 40, "pebbles": 1})

; omit

assert.label("default .identity argument")
assert.test(A.mapValues([0, 1, 2]), {"1": 0, "2": 1, "3": 2})
assert.test(A.mapValues([1, 2, 3]), [1, 2, 3])
