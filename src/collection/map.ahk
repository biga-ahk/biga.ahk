map(param_collection,param_iteratee:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	if (this._internal_detectOwnMethods(param_iteratee)) {
		detailObj := this._internal_iterateeDetails(param_iteratee)
	}
	shorthand := this._internal_detectShorthand(param_iteratee, param_collection)
	if (this.includes([".property", "__identity", "_classMethod"], shorthand)) {
		param_iteratee := this._internal_createShorthandfn(param_iteratee, param_collection)
	}
	l_collection := this.cloneDeep(param_collection)
	l_array := []

	; create
	; guarded method
	if (detailObj.guarded) {
		for key, value in param_collection {
			l_array.push(detailObj.iteratee.call(value))
		}
		return l_array
	}
	; functor
	for key, value in param_collection {
		l_array.push(param_iteratee.call(value, key, l_collection))
	}
	return l_array
}


; tests
fn_square(n)
{
	return n * n
}

assert.test(A.map([4, 8], func("fn_square")), [16, 64])
assert.test(A.map({ "a": 4, "b": 8 }, func("fn_square")), [16, 64])
assert.test(A.map({ "a": 4, "b": 8 }), [4, 8])

; The A.property shorthand
assert.label(".property shorthand")
users := [{ "user": "barney" }, { "user": "fred" }]
assert.test(A.map(users, "user"), ["barney", "fred"])


; omit
assert.label("call own biga.ahk method (guarded)")
assert.test(A.map([" hey ", "hey", " hey	"], A.trim), ["hey", "hey", "hey"])

assert.label("call own biga.ahk method (unguarded)")
assert.test(A.map(["hello", "world"], A.castArray), [["hello"], ["world"]])

assert.label("call with 2 parameters")
assert.test(A.map([1, 2], func("fn_map2")), ["1-1", "2-2"])
fn_map2(param1, param2)
{
	return param1 "-" param2
}

assert.label("call with 3 parameters")
assert.test(A.map([1, 2], func("fn_map3")), ["1-1-1", "2-2-1"])
fn_map3(param1, param2, param3)
{
	return param1 "-" param2 "-" param3[1]
}

assert.label("default .identity argument")
assert.test(A.map([1, 2, 3]), [1, 2, 3])


assert.label("guarded random method")
rands := A.map([1, 2, 3, 4, 5, 6, 7, 8], A.random)
assert.test(rands.count(), 8)
assert.true(A.every(rands, A.isNumber))
