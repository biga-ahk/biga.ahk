size(param_collection) {

	; prepare
	if (param_collection.count() == 0) {
		return ""
	}

	; create
	if (max := this.max([param_collection.count(), param_collection.maxIndex()])) {
		return max
	}
	return strLen(param_collection)
}


; tests
assert.test(A.size([1, 2, 3]), 3)
assert.test(A.size({ "a": 1, "b": 2 }), 2)
assert.test(A.size("pebbles"), 7)
assert.test(A.size([]), "")


; omit
assert.label("objects")
users := [{"user": "barney", "active": true}
	, {"user": "fred", "active": false}
	, {"user": "pebbles", "active": false}]
assert.test(A.size(users), 3)

assert.label("empty values")
assert.test(A.size(["A", , "C"]), 3)
