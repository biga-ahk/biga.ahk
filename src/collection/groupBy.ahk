groupBy(param_collection,param_iteratee:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_iteratee, param_collection)
	if (shorthand != false) {
		param_iteratee := this._internal_createShorthandfn(param_iteratee, param_collection)
	}

	; create
	l_array := []
	for key, value in param_collection {
		vIteratee := 0

		; functor
		if (this.isFunction(param_iteratee) || !vIteratee) {
			vIteratee := param_iteratee.call(value)
		}
		; create array at key if not encountered yet
		if (!l_array.hasKey(vIteratee)) {
			l_array[vIteratee] := []
		}
		; add value to this key
		l_array[vIteratee].push(value)
	}
	return l_array
}


; tests
assert.test(A.groupBy([6.1, 4.2, 6.3], A.floor), {4: [4.2], 6: [6.1, 6.3]})

assert.test(A.groupBy(["one", "two", "three"], A.size), {3: ["one", "two"], 5: ["three"]})

assert.test(A.groupBy([6.1, 4.2, 6.3], func("Ceil")), {5: [4.2], 7: [6.1, 6.3]})


; omit
users := [ { "user": "barney", "lastActive": "Tuesday" }
		, { "user": "fred", "lastActive": "Monday" }
		, { "user": "pebbles", "lastActive": "Tuesday" } ]

assert.test(A.groupBy(users, "lastActive"), {"Monday": [{ "user": "fred", "lastActive": "Monday" }], "Tuesday": [{ "user": "barney", "lastActive": "Tuesday" }, { "user": "pebbles", "lastActive": "Tuesday" }]})

assert.label("default .identity argument")
assert.test(A.groupBy([6.1, 4.2, 6.3]), {"6.1": [6.1], "4.2": [4.2], "6.3": [6.3]})
