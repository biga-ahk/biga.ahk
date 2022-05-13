mapKeys(param_object,param_iteratee:="__identity") {
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
; assert.test(A.mapkeys([ {"false": 0}, {"true": 1} ]), [ {0: "false"}, {1: "true"} ])

assert.label("default .identity argument")
assert.test(A.mapkeys([0, 1, 2]), {"0": 1, "1": 2, "2": 3})
assert.test(A.mapkeys([1, 2, 3]), [1, 2, 3])
