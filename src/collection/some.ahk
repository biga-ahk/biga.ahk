some(param_collection,param_predicate) {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_predicate, param_collection)
	if (shorthand != false) {
		boundFunc := this._internal_createShorthandfn(param_predicate, param_collection)
	}
	if (param_predicate.maxParams > 0) {
		boundFunc := param_predicate.bind()
	}

	; create
	for key, value in param_collection {
		if (shorthand != false) {
			if (boundFunc.call(value, key, param_collection) = true) {
				return true
			}
		} else {
			if (param_predicate.call(value, key, param_collection) == true) {
				return true
			}
		}
	}
	return false
}


; tests
users := [{ "user": "barney", "active": true }, { "user": "fred", "active": false }]

; The `A.matches` iteratee shorthand.
assert.label("A.matches iteratee shorthand.")
assert.false(A.some(users, { "user": "barney", "active": false }))

; The `A.matchesProperty` iteratee shorthand.
assert.label("A.matchesProperty iteratee shorthand.")
assert.true(A.some(users, ["active", false]))

; The `A.property` iteratee shorthand.
assert.label("A.property iteratee shorthand.")
assert.true(A.some(users, "active"))


; omit
