forEach(param_collection,param_iteratee:="__identity") {
	if (!IsObject(param_collection)) {
		this.internal_ThrowException()
	}
	; check what kind of param_iteratee being worked with
	if (!IsFunc(param_iteratee)) {
		BoundFunc := param_iteratee.Bind(this)
	}

	; prepare data
	l_paramAmmount := param_iteratee.MaxParams
	if (l_paramAmmount == 3) {
		collectionClone := this.cloneDeep(param_collection)
	}

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
assert.test(A.forEach([1, 2], Func("forEachFunc1")), [1, 2])
forEachFunc1(value) {
   ; msgbox, % value
}
; msgboxes `1` then `2`
