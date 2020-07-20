dropWhile(param_array,param_predicate:="__identity") {

	; data setup
	shorthand := this.internal_differenciateShorthand(param_predicate, param_array)
	; msgbox, % shorthand
	if (shorthand != false) {
		boundFunc := this.internal_createShorthandfn(param_predicate, param_array)
	}
	if (IsFunc(param_predicate)) {
		boundFunc := param_predicate.Bind()
	}

	; create
	l_array := this.cloneDeep(param_array)
	; return empty array if empty
	if (l_array.Count() == 0) {
		return []
	}
	while (true) {
		msgbox, % "Key: " 1 " was " boundFunc.call(l_array[1], 1, param_array)
		if (boundFunc.call(l_array[1], 1, param_array)) {
			l_array.RemoveAt(1)
		} else {
			break
		}
	}
	return l_array
}


; tests
users := [ {"user": "barney", "active": false }
		, { "user": "fred", "active": false }
		, { "user": "pebbles", "active": true } ]
assert.test(A.dropWhile(users, Func("fn_dropWhile")), [{ "user": "pebbles", "active": true }])
fn_dropWhile(o)
{
	return !o.active
}

; The `A.matches` iteratee shorthand.
assert.test(A.dropWhile(users, {"user": "barney", "active": false}), [ { "user": "fred", "active": false }, { "user": "pebbles", "active": true }  ])

; The `A.matchesProperty` iteratee shorthand.
assert.test(A.dropWhile(users, ["active", false]), [ {"user": "pebbles", "active": true } ])

; The `A.property` iteratee shorthand.
assert.test(A.dropWhile(users, "active"), [ {"user": "barney", "active": false }, { "user": "fred", "active": false }, { "user": "pebbles", "active": true } ])


; omit
assert.test(A.dropWhile([]), [])
