mapValues(param_object,param_iteratee:="__identity") {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_iteratee, param_object)
	if (shorthand == ".property") {
		param_iteratee := this.property(param_iteratee)
	}
	if (this.startsWith(param_iteratee.name, this.base.__Class ".")) { ;if starts with "biga."
		param_iteratee := param_iteratee.bind(this)
	}
	l_object := this.cloneDeep(param_object)
	l_array := {}

	; create
	for key, value in l_object {
		if (param_iteratee == "__identity") {
			l_array[key] := value
			continue
		}
		; functor function
		if (this.isCallable(param_iteratee)) {
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
