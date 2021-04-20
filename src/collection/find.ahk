find(param_collection,param_predicate,param_fromindex:=1) {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_predicate, param_collection)
	if (shorthand != false) {
		boundFunc := this._internal_createShorthandfn(param_predicate, param_collection)
	}

	; create
	for key, value in param_collection {
		if (param_fromindex > A_Index) {
			continue
		}
		; undeteriminable functor
		if (param_predicate.call(value)) {
			return value
		}
		; regular function
		if (isFunc(param_predicate)) {
			if (param_predicate.call(value)) {
				return value
			}
			continue
		}
		; shorthand
		if (boundFunc.call(value) && shorthand) {
			return value
		}
	}
	return false
}


; tests
users := [ {"user": "barney", "age": 36, "active": true}
	, {"user": "fred", "age": 40, "active": false}
	, {"user": "pebbles", "age": 1, "active": true} ]

assert.test(A.find(users, Func("fn_findFunc")), { "user": "barney", "age": 36, "active": true })
fn_findFunc(o)
{
	return o.active
}

; The A.matches iteratee shorthand.
assert.test(A.find(users, { "age": 1, "active": true }), { "user": "pebbles", "age": 1, "active": true })

; The A.matchesProperty iteratee shorthand.
assert.test(A.find(users, ["active", false]), { "user": "fred", "age": 40, "active": false })

; The A.property iteratee shorthand.
assert.test(A.find(users, "active"), { "user": "barney", "age": 36, "active": true })


; omit
assert.test(A.find(users, "active", 2), { "user": "pebbles", "age": 1, "active": true }) ;fromindex argument
