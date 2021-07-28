partition(param_collection,param_predicate:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	trueArray := []
	falseArray := []
	shorthand := this._internal_differenciateShorthand(param_predicate, param_collection)
	if (shorthand) {
		param_predicate := this._internal_createShorthandfn(param_predicate, param_collection)
	}

	; create
	for key, value in param_collection {
		if (this.isFalsey(param_predicate.call(value))) {
			falseArray.push(value)
		} else {
			trueArray.push(value)
		}
	}
	return [trueArray, falseArray]
}


; tests
users := [ { "user": "barney", "age": 36, "active": false }
	, { "user": "fred", "age": 40, "active": true }
	, { "user": "pebbles", "age": 1, "active": false } ]

assert.test(A.partition(users, func("fn_partitionFunc")), [[{ "user": "fred", "age": 40, "active": true }], [{ "user": "barney", "age": 36, "active": false }, { "user": "pebbles", "age": 1, "active": false }]])
fn_partitionFunc(o)
{
	return o.active
}

; The A.matches iteratee shorthand.
assert.test(A.partition(users, {"age": 1, "active": false}), [[{ "user": "pebbles", "age": 1, "active": false }], [{ "user": "barney", "age": 36, "active": false }, { "user": "fred", "age": 40, "active": true }]])

; The A.propertyMatches iteratee shorthand.
assert.test(A.partition(users, ["active", false]), [[{ "user": "barney", "age": 36, "active": false }, { "user": "pebbles", "age": 1, "active": false }] ,[{ "user": "fred", "age": 40, "active": true }]])

; The A.property iteratee shorthand.
assert.test(A.partition(users, "active"), [[{ "user": "fred", "age": 40, "active": true }], [{ "user": "barney", "age": 36, "active": false }, { "user": "pebbles", "age": 1, "active": false }]])


; omit
assert.label("default .identity argument")
assert.test(A.partition([1, 2, 3]), [[1, 2, 3], []])
