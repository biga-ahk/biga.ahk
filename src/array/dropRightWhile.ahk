dropRightWhile(param_array,param_predicate:="__identity") {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}
	; validate
	; return empty array if empty
	if (param_array.count() == 0) {
		return []
	}

	l_array := this.reverse(this.cloneDeep(param_array))
	return this.reverse(this.dropWhile(l_array, param_predicate))
}


; tests
users := [ {"user": "barney", 	"active": true}
		, {"user": "fred",		"active": false}
		, {"user": "pebbles", 	"active": false} ]
assert.test(A.dropRightWhile(users, func("fn_dropRightWhile")), [{"user": "barney", "active": true }])
fn_dropRightWhile(o)
{
	return !o.active
}

; The A.matches iteratee shorthand.
assert.label("A.matches iteratee shorthand")
assert.test(A.dropRightWhile(users, {"user": "pebbles", "active": false}), [ {"user": "barney", "active": true }, {"user": "fred", "active": false} ])

; The A.matchesProperty iteratee shorthand.
assert.label("A.matchesProperty iteratee shorthand")
assert.test(A.dropRightWhile(users, ["active", false]), [ {"user": "barney", "active": true } ])

; The A.property iteratee shorthand.
assert.label("A.property iteratee shorthand")
assert.test(A.dropRightWhile(users, "active"), [ {"user": "barney", "active": true }, {"user": "fred", "active": false }, {"user": "pebbles", "active": false} ])


; omit
assert.label("empty array")
assert.test(A.dropRightWhile([]), [])

assert.label("A.property iteratee no drops")
assert.test(A.dropRightWhile([{"user": "barney", "active": false}, {"user": "fred", "active": false}], "active"), [{"user": "barney", "active": false }, {"user": "fred", "active": false}])

assert.label("A.property iteratee all dropped")
assert.test(A.dropRightWhile([{"user": "barney", "active": false}, {"user": "fred", "active": false}], "active"), [{"user": "barney", "active": false }, {"user": "fred", "active": false}])

assert.label("check that input has not been mutated")
assert.test(users[3], {"user": "pebbles",	"active": false})

assert.label("default .identity argument")
assert.test(A.dropRightWhile(["foo", 0, "bar"]), ["foo", 0])

assert.label("undefined array")
assert.test(A.dropRightWhile([]), [])

assert.label("undefined elements")
assert.test(A.dropRightWhile(["", "", ""]), ["", "", ""])
