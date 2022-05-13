forEachRight(param_collection,param_iteratee:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_iteratee, param_collection)
	if (shorthand != false) {
		param_iteratee := this._internal_createShorthandfn(param_iteratee, param_collection)
	}
	collectionClone := this.reverse(this.cloneDeep(param_collection))

	; create
	; run against every value in the collection
	for key, value in collectionClone {
		if (this.isFunction(param_iteratee)) {
			vIteratee := param_iteratee.call(value, key, collectionClone)
		}
		; exit iteration early by explicitly returning false
		if (vIteratee == false) {
			return collectionClone
		}
	}
	return param_collection
}


; tests


; omit
assert.label("order")
obj := []
A.forEachRight([1, 2], Func("fn_forEachRightFuncGlobal"))
assert.test(obj, [3, 2])
fn_forEachRightFuncGlobal(value)
{
	global
	obj.push(value + 1)
}


assert.label("alias")
assert.test(A.eachRight([1, 2], Func("fn_forEachRightFuncGlobal")), [1, 2])

assert.label("default .identity argument")
assert.test(A.forEachRight([1, 2], Func("fn_forEachRightFunc")), [1, 2])
