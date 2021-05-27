mapKeys(param_object,param_iteratee:="__identity") {
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
			l_array[value] := A_Index
			continue
		}
		; functor
		if (this.isCallable(param_iteratee)) {
			l_array[param_iteratee.call(value, key, l_object)] := A_Index
		}
	}
	return l_array
}


; tests
assert.test(A.mapKeys({"a": 1, "b": 2}, Func("fn_mapKeysFunc")), {"a+1": 1, "b+2": 2})
fn_mapKeysFunc(value, key)
{
	return key "+" value
}


; omit
assert.test(A.mapkeys([ {"false": 0}, {"true": 1} ]), [ {0: "false"}, {1: "true"} ])
