; ###incomplete###
dropWhile(param_array,param_predicate) {

	; data setup
	shorthand := this.internal_differenciateShorthand(param_predicate, param_array)
	msgbox, % shorthand
	if (shorthand != false) {
		boundFunc := this.internal_createShorthandfn(param_predicate, param_array)
	}

	; create
	l_array := this.cloneDeep(param_array)
	for Key, Value in l_array {
		if (shorthand != false) {
			if (!boundFunc.call(Value, Key, param_array)) {
				msgbox, % boundFunc.call(Value, Key, param_array) " so removing " Key
				l_array.RemoveAt(Key)
			} else {
				break
			}
		}
	}
	; return empty array if empty
	if (l_array.Count() == 0) {
		return []
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
; assert.test(A.dropWhile(users, {"user": "barney", "active": false}), [ { "user": "fred", "active": false }, { "user": "pebbles", "active": true }  ])

; The `A.matchesProperty` iteratee shorthand.
assert.test(A.dropWhile(users, ["active", false]), [ {"user": "pebbles", "active": true } ])

; The `A.property` iteratee shorthand.
; assert.test(A.dropWhile(users, "active"), [ {"user": "barney", "active": false }, { "user": "fred", "active": false }, { "user": "pebbles", "active": true } ])


; omit
assert.test(A.dropWhile([]), [])
