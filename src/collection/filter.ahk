filter(param_collection,param_predicate:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_predicate, param_collection)
	if (shorthand != false) {
		param_predicate := this._internal_createShorthandfn(param_predicate, param_collection)
	}
	collectionClone := []
	l_paramAmmount := param_predicate.maxParams
	l_array := []
	if (l_paramAmmount == 3) {
		collectionClone := this.cloneDeep(param_collection)
	}

	; create
	for key, value in param_collection {
		; functor
		if (this.isFunction(param_predicate)) {
			if (param_predicate.call(value, key, collectionClone)) {
				l_array.push(value)
			}
		}
	}
	return l_array
}


; tests
users := [{"user":"barney", "age":36, "active":true}, {"user":"fred", "age":40, "active":false}]

assert.test(A.filter(users, Func("fn_filterFunc")), [{"user":"barney", "age":36, "active":true}])
fn_filterFunc(param_iteratee)
{
	if (param_iteratee.active) {
		return true
	}
}

; The A.matches shorthand
assert.test(A.filter(users, {"age":36, "active":true}), [{"user":"barney", "age":36, "active":true}])

; The A.matchesProperty shorthand
assert.test(A.filter(users, ["active", false]), [{"user":"fred", "age":40, "active":false}])

; The A.property shorthand
assert.test(A.filter(users, "active"), [{"user":"barney", "age":36, "active":true}])


; omit
assert.label(".matches longhand")
assert.test(A.filter(users, A.matches({"user": "fred"})), [{"user":"fred", "age":40, "active":false}])

assert.label("using value")
assert.test(A.filter([1,2,3,-10,1.9], Func("fn_filter2")), [2,3])
fn_filter2(param_iteratee) {
	if (param_iteratee >= 2) {
		return true
	}
}

assert.label("using value and key")
assert.test(A.filter([1,2,3,-10,1.9,"even"], Func("fn_filter3")), [2,-10,"even"])
fn_filter3(param_iteratee, param_key) {
	if (mod(param_key, 2) = 0) {
		return true
	}
}

assert.label("using value, key, and collection")
assert.test(A.filter([1,2,3,-10,1.9,"even"], Func("fn_filter4")), [2])
fn_filter4(param_iteratee, param_key, param_collection) {
	A := new biga()
	if (mod(param_key, 2) = 0 && A.indexOf(param_collection, param_iteratee / 2) != -1) {
		return true
	}
}
