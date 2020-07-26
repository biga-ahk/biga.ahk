dropWhile(param_array,param_predicate:="__identity") {
	if (!IsObject(param_array)) {
		this._internal_ThrowException()
	}
	; validate
	; return empty array if empty
	if (param_array.Count() == 0) {
		return []
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_predicate, param_array)
	if (shorthand != false) {
		boundFunc := this._internal_createShorthandfn(param_predicate, param_array)
	}
	if (IsFunc(param_predicate)) {
		boundFunc := param_predicate.Bind()
	}

	; create
	l_array := this.cloneDeep(param_array)
	l_droppableElements := 0
	for Key, Value in l_array {
		if (!this.isFalsey(boundFunc.call(Value, Key, l_array))) {
			l_droppableElements++
		} else {
			break
		}
	}
	if (l_droppableElements >= 1) {
		l_array.RemoveAt(1, l_droppableElements)
	}
	return l_array
}


; tests
users := [ {"user": "barney", 	"active": false }
		, { "user": "fred", 	"active": false }
		, { "user": "pebbles", 	"active": true } ]
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
