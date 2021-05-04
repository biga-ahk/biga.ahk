find(param_collection,param_predicate,param_fromindex:=1) {
	if (!isObject(param_collection) || !this.isNumber(param_fromindex)) {
		this._internal_ThrowException()
	}

	; create
	foundIndex := this.findIndex(param_collection, param_predicate, param_fromindex)
	if (foundIndex != -1) {
		return param_collection[foundIndex]
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
assert.label("fromindex argument")
assert.test(A.find(users, "active", 2), { "user": "pebbles", "age": 1, "active": true })
