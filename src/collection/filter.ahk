filter(param_collection,param_predicate:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_predicate, param_collection)
	if (shorthand != false) {
		boundFunc := this._internal_createShorthandfn(param_predicate, param_collection)
	}
	l_paramAmmount := param_predicate.maxParams
	if (l_paramAmmount == 3) {
		collectionClone := this.cloneDeep(param_collection)
	}
	l_array := []

	; create
	for Key, Value in param_collection {
		if (l_paramAmmount == 3) {
			vIteratee := param_predicate.call(Value, Key, collectionClone)
			if (vIteratee) {
				l_array.push(Value)
			}
			continue
		}
		if (l_paramAmmount == 2) {
			vIteratee := param_predicate.call(Value, Key)
			if (vIteratee) {
				l_array.push(Value)
			}
			continue
		}
		if (l_paramAmmount == 1) {
			vIteratee := param_predicate.call(Value)
			if (vIteratee) {
				l_array.push(Value)
			}
			continue
		}
		; functor
		if (IsFunc(param_predicate)) {
			if (param_predicate.call(Value)) {
				l_array.push(Value)
			}
			continue
		}
		; calling own method
		vValue := param_predicate.call(Value)
		if (vValue) {
			l_array.push(Value)
			continue
		}
		; shorthand
		if (shorthand != false) {
			if (boundFunc.call(Value)) {
				l_array.push(Value)
			}
			continue
		}
	}
	return l_array
}


; tests
users := [{"user":"barney", "age":36, "active":true}, {"user":"fred", "age":40, "active":false}]

assert.test(A.filter(users, Func("fn_filterFunc")), [{"user":"barney", "age":36, "active":true}])
fn_filterFunc(param_iteratee) {
	if (param_iteratee.active) {
		return true
	}
}

; The A.matches shorthand
assert.test(A.filter(users, {"age": 36,"active":true}), [{"user":"barney", "age":36, "active":true}])

; The A.matchesProperty shorthand
assert.test(A.filter(users, ["active", false]), [{"user":"fred", "age":40, "active":false}])

; The A.property shorthand
assert.test(A.filter(users, "active"), [{"user":"barney", "age":36, "active":true}])


; omit
assert.test(A.filter([1,2,3,-10,1.9], Func("fn_filter2")), [2,3])
fn_filter2(param_iteratee) {
	if (param_iteratee >= 2) {
		return true
	}
}

assert.label("filter - using value and key")
assert.test(A.filter([1,2,3,-10,1.9,"even"], Func("fn_filter3")), [2,-10,"even"])
fn_filter3(param_iteratee, param_key) {
	if (mod(param_key, 2) = 0) {
		return true
	}
}

assert.label("filter - using value, key, and collection")
assert.test(A.filter([1,2,3,-10,1.9,"even"], Func("fn_filter4")), [2])
fn_filter4(param_iteratee, param_key, param_collection) {
	if (mod(param_key, 2) = 0 && A.indexOf(param_collection, param_iteratee / 2) != -1) {
		return true
	}
}
