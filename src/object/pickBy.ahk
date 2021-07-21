pickBy(param_object,param_predicate:="__identity") {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_predicate, param_collection)
	if (shorthand) {
		param_predicate := this._internal_createShorthandfn(param_predicate, param_collection)
	}
	l_obj := {}
	l_paramAmmount := param_predicate.maxParams

	; create
	for key, value in param_object {
		if (this.isCallable(param_predicate)) {
			vItaree := param_predicate.call(value, key)
			if (vItaree) {
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
