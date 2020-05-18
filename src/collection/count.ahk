count(param_collection,param_predicate,param_fromIndex:=1) {

	; data setup
	if (param_collection is alnum) {
		param_collection := StrSplit(param_collection)
	}
	shorthand := this.internal_differenciateShorthand(param_predicate, param_collection)
	if (shorthand != false) {
		boundFunc := this.internal_createShorthandfn(param_predicate, param_collection)
	}

	; create the slice
	l_count := 0
	for Key, Value in param_collection {
		if (Key < param_fromIndex) {
			continue
		}
		if (shorthand != false) {
			if (boundFunc.call(Value, Key, param_collection) == true) {
				l_count++
				continue
			}
		}
		if (this.isEqual(Value, param_predicate)) {
			l_count++
		}
	}
	return l_count
}


; tests
assert.test(A.count([1, 2, 3], 2), 1)
assert.test(A.count("pebbles", "b"), 2)
assert.test(A.count(["fred", "barney", "pebbles"], "barney"), 1)

users := [ {"user": "fred", "age": 40, "active": true}
		, {"user": "barney", "age": 36, "active": false}
		, {"user": "pebbles", "age": 1, "active": false} ]

; The `A.matches` iteratee shorthand.
assert.test(A.count(users, {"age": 1, "active": false}), 1)

; The `A.matchesProperty` iteratee shorthand.
assert.test(A.count(users, ["active", false]), 2)

; The `A.property` iteratee shorthand.
assert.test(A.count(users, "active"), 1)
