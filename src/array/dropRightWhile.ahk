; ###incomplete###
dropRightWhile(param_array,param_n:=1) {

	; data setup
	if (IsObject(param_array)) {
		l_array := this.cloneDeep(param_array)
	}
	if (param_array is alnum) {
		l_array := StrSplit(param_array)
	}
	param_array := this.reverse(l_array)
	; l_array := this.reverse(l_array)
	shorthand := this._internal_differenciateShorthand(param_predicate, param_collection)
	if (shorthand != false) {
		boundFunc := this._internal_createShorthandfn(param_predicate, param_collection)
	}

	; create the slice
	for Key, Value in param_array {
		if (shorthand != false) {
			if (boundFunc.call(Value, Key, param_array) == true) {
				l_array.pop()
			} else {
				break
			}
		}
	}
	; return empty array if empty
	if (l_array.Count() == 0) {
		return []
	}
	return this.reverse(l_array)
}


; tests
users := [ {"user": "barney", "active": true }
		, { "user": "fred", "active": false }
		, { "user": "pebbles", "active": false } ]
assert.test(A.dropRightWhile(users, Func("fn_dropRightWhile1")), [{"user": "barney", "active": true }])
fn_dropRightWhile1(0)
{
	return !o.active
}

; The `A.matches` iteratee shorthand.
assert.test(A.dropRightWhile(users, {"user": "pebbles", "active": false}), [ {"user": "barney", "active": true }, { "user": "fred", "active": false } ])

; The `A.matchesProperty` iteratee shorthand.
assert.test(A.dropRightWhile(users, ["active", false]), [  {"user": "barney", "active": true } ])

; The `A.property` iteratee shorthand.
assert.test(A.dropRightWhile(users, "active"), [ {"user": "barney", "active": true }, { "user": "fred", "active": false }, { "user": "pebbles", "active": false } ])


; omit
assert.test(A.dropRightWhile([]), [])
