forEach(param_collection,param_iteratee:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_iteratee, param_collection)
	if (shorthand != false) {
		param_iteratee := this._internal_createShorthandfn(param_iteratee, param_collection)
	}
	param_collection := this.cloneDeep(param_collection)

	; create
	; run against every value in the collection
	for key, value in param_collection {
		if (this.isFunction(param_iteratee)) {
			vIteratee := param_iteratee.call(value, key, param_collection)
		}
		; exit iteration early by explicitly returning false
		if (vIteratee == false) {
			return param_collection
		}
	}
	return param_collection
}


; tests


; omit
assert.label("order")
obj := []
A.forEach([1, 2], Func("fn_forEachGlobal"))
assert.test(obj, [2, 3])
fn_forEachGlobal(value)
{
	global
	obj.push(value + 1)
}


assert.label("alias")
assert.test(A.each([1, 2], Func("fn_forEachFunc")), [1, 2])

assert.label("default .identity argument")
assert.test(A.forEach(["foo", 0, "bar"]), ["foo", 0, "bar"])
