forEach(param_collection,param_iteratee:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	if (!IsFunc(param_iteratee)) {
		boundFunc := param_iteratee.Bind(this)
	}
	if (l_paramAmmount == 3) {
		collectionClone := this.cloneDeep(param_collection)
	}

	; create
	; run against every value in the collection
	for Key, Value in param_collection {
		if (!boundFunc) { ; is property/string
			;nothing currently
		}
		if (!boundFunc.call(Value, Key, collectionClone)) {
			vIteratee := param_iteratee.call(Value, Key, collectionClone)
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
assert.test(A.forEach([1, 2], Func("fn_forEachFunc")), [1, 2])
fn_forEachFunc(value) {
   ; msgbox, % value
}
; msgboxes `1` then `2`


; aliases
assert.test(A.each([1, 2], Func("fn_forEachFunc")), [1, 2])
