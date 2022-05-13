keyBy(param_collection,param_iteratee:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_iteratee, param_collection)
	if (shorthand) {
		param_iteratee := this._internal_createShorthandfn(param_iteratee, param_collection)
	}
	l_obj := {}


	; run against every value in the collection
	for key, value in param_collection {
		if (this.isFunction(param_iteratee)) {
			vIteratee := param_iteratee.call(value, key, param_collection)
			l_obj[vIteratee] := value
		}
	}
	return l_obj
}


; tests
array := [ {"dir": "left", "code": 97}
	, {"dir": "right", "code": 100}]
assert.test(A.keyBy(array, Func("fn_keyByFunc")), {"left": {"dir": "left", "code": 97}, "right": {"dir": "right", "code": 100}})

fn_keyByFunc(value)
{
	return value.dir
}

; The A.property iteratee shorthand.
assert.test(A.keyBy(array, "dir"), {"left": {"dir": "left", "code": 97}, "right": {"dir": "right", "code": 100}})

; omit
assert.label("default .identity argument")
assert.test(A.keyBy([1, 2, 3]), [1, 2, 3])
