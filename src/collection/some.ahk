some(param_collection,param_predicate:="__identity") {
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
		if (this.isFunction(param_predicate)) {
			if (param_predicate.call(value, key, param_collection) = true) {
				return true
			}
		}
	}
	return false
}


; tests
users := [{ "user": "barney", "active": true }, { "user": "fred", "active": false }]

; The A.matches iteratee shorthand.
assert.label("A.matches iteratee shorthand.")
assert.false(A.some(users, { "user": "barney", "active": false }))

; The A.matchesProperty iteratee shorthand.
assert.label("A.matchesProperty iteratee shorthand.")
assert.true(A.some(users, ["active", false]))

; The A.property iteratee shorthand.
assert.label("A.property iteratee shorthand.")
assert.true(A.some(users, "active"))


; omit
assert.label("default .identity argument")
assert.true(A.some([0, 1, 2]))
