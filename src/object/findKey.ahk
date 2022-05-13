findKey(param_collection,param_predicate,param_fromindex:=1) {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_predicate, param_collection)
	if (shorthand != false) {
		param_predicate := this._internal_createShorthandfn(param_predicate, param_collection)
	}

	; create
	for key, value in param_collection {
		if (param_fromindex > A_Index) {
			continue
		}
		; functor
		if (this.isFunction(param_predicate)) {
			if (param_predicate.call(value)) {
				return key
			}
		}
	}
	return false
}


; tests
users := { "barney": {"age": 36, "active": true}
, "fred": {"age": 40, "active": false}
, "pebbles": {"age": 1, "active": true} }

assert.test(A.findKey(users, Func("fn_findKeyFunc")), "barney")
fn_findKeyFunc(o)
{
	return o.age < 40
}

; The A.matches iteratee shorthand.
assert.test(A.findKey(users, {"age": 1, "active": true}), "pebbles")

; The A.matchesProperty iteratee shorthand.
assert.test(A.findKey(users, ["active", false]), "fred")

; The A.property iteratee shorthand.
assert.test(A.findKey(users, "active"), "barney")


; omit
assert.test(A.findKey(users, "active", 2), "pebbles") ;fromindex argument
