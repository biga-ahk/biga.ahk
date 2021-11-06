size(param_collection) {

	; create
	if (isObject(param_collection)) {
		return param_collection.count()
	}
	return strLen(param_collection)
}


; tests
assert.test(A.size([1, 2, 3]), 3)
assert.test(A.size({ "a": 1, "b": 2 }), 2)
assert.test(A.size("pebbles"), 7)


; omit
assert.label("empty array")
assert.test(A.size([]), 0)
assert.label("objects")
users := [{"user": "barney", "active": true}
	, {"user": "fred", "active": false}
	, {"user": "pebbles", "active": false}]
assert.test(A.size(users), 3)

assert.label("empty values")
assert.test(A.size(["A", "", "C"]), 3)
