groupBy(param_collection,param_iteratee:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	; check what kind of param_iteratee being worked with
	if (!param_iteratee.call(this.head(param_collection))) { ;calling own method
		boundFunc := param_iteratee.bind(this)
		thisThing := "boundfunc"
	}
	shorthand := this._internal_differenciateShorthand(param_iteratee, param_collection)
	if (shorthand == ".property") {
		boundFunc := this._internal_createShorthandfn(param_iteratee, param_collection)
	}

	; create
	l_array := []
	for Key, Value in param_collection {
		if (thisThing == "boundfunc") {
			; calling own method
			vIteratee := boundFunc.call(Value)
		} else {
			; functor
			vIteratee := param_iteratee.call(Value)
		}
		if (shorthand == ".property") {
			; property shorthand
			vIteratee := Value[param_iteratee]
		}

		; create array at key if not encountered yet
		if (!l_array.hasKey(vIteratee)) {
			l_array[vIteratee] := []
		}
		; add value to this key
		l_array[vIteratee].push(Value)
	}
	return l_array
}


; tests
assert.test(A.groupBy([6.1, 4.2, 6.2], A.floor), {4: [4.2], 6: [6.1, 6.2]})

assert.test(A.groupBy([6.1, 4.2, 6.3], func("Ceil")), {5: [4.2], 7: [6.1, 6.3]})

; The `A.property` iteratee shorthand.
users := [ { "user": "barney", "lastActive": "Monday" }
		, { "user": "fred", "lastActive": "Tuesday" }
		, { "user": "pebbles", "lastActive": "Tuesday" } ]
assert.test(A.groupBy(users, "lastActive"), {"Monday": [{ "user": "barney", "lastActive": "Monday" }], "Tuesday": [{ "user": "fred", "lastActive": "Tuesday" }, { "user": "pebbles", "lastActive": "Tuesday" }]})


; omit

assert.test(A.groupBy(["one", "two", "three"], A.size), {3: ["one", "two"], 5: ["three"]})
