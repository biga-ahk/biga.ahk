mapKeys(param_object,param_iteratee:="__identity") {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_iteratee, param_object)
	if (shorthand == ".property") {
		param_iteratee := this.property(param_iteratee)
	}
	if (this.startsWith(param_iteratee.name, this.__Class ".")) { ;if starts with "biga."
		param_iteratee := param_iteratee.bind(this)
	}
	param_object := this.cloneDeep(param_object)
	l_array := {}

	; create
	for key, value in param_object {
		if (param_iteratee == "__identity") {
			l_array[value] := A_Index
			continue
		}
		; calling own method
		if (!isFunc(param_iteratee)) { ;somehow NOT a function
			l_array[param_iteratee.call(value, key)] := A_Index
			continue
		}
		; regular function
		l_array[param_iteratee.call(value, key, param_object)] := A_Index
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
