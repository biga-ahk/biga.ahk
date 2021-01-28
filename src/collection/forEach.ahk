forEach(param_collection,param_iteratee:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	if (!IsFunc(param_iteratee)) {
		BoundFunc := param_iteratee.Bind(this)
	}
	l_paramAmmount := param_iteratee.maxParams
	if (l_paramAmmount == 3) {
		collectionClone := this.cloneDeep(param_collection)
	}

	; create
	; run against every value in the collection
	for Key, Value in param_collection {
		if (!BoundFunc) { ; is property/string
			;nothing currently
		}
		if (l_paramAmmount == 3) {
			if (!BoundFunc.call(Value, Key, collectionClone)) {
				vIteratee := param_iteratee.call(Value, Key, collectionClone)
			}
		}
		if (l_paramAmmount == 2) {
			if (!BoundFunc.call(Value, Key)) {
				vIteratee := param_iteratee.call(Value, Key)
			}
		}
		if (l_paramAmmount == 1) {
			if (!BoundFunc.call(Value)) {
				vIteratee := param_iteratee.call(Value)
			}
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
