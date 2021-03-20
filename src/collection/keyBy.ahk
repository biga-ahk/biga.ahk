keyBy(param_collection,param_iteratee:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}
	; check what kind of param_iteratee being worked with
	if (!isFunc(param_iteratee)) {
		boundFunc := param_iteratee.Bind(this)
	}

	; prepare
	l_paramAmmount := param_iteratee.maxParams
	if (l_paramAmmount == 3) {
		collectionClone := this.cloneDeep(param_collection)
	}
	l_obj := {}


	; run against every value in the collection
	for key, value in param_collection {
		if (!boundFunc) { ; is property/string
			;nothing currently
		}
		if (l_paramAmmount == 3) {
			if (!boundFunc.call(value, key, collectionClone)) {
				vIteratee := param_iteratee.call(value, key, collectionClone)
			}
		}
		if (l_paramAmmount == 2) {
			if (!boundFunc.call(value, key)) {
				vIteratee := param_iteratee.call(value, key)
			}
		}
		if (l_paramAmmount == 1) {
			if (!boundFunc.call(value)) {
				vIteratee := param_iteratee.call(value)
			}
		}
		ObjRawSet(l_obj, vIteratee, value)
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

; omit
