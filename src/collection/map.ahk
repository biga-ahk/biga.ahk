map(param_collection,param_iteratee:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_iteratee, param_collection)
	if (shorthand == ".property") {
		param_iteratee := this._internal_createShorthandfn(param_iteratee, param_collection)
	}
	if (this.startsWith(param_iteratee.name, this.base.__Class ".")) { ;if starts with "biga."
		guarded := this.includes(this._guardedMethods, strSplit(param_iteratee.name, ".").2)
		param_iteratee := param_iteratee.bind(this)
	}
	l_collection := this.cloneDeep(param_collection)
	l_array := []

	; create
	for key, value in param_collection {
		if (param_iteratee == "__identity") {
			l_array.push(value)
			continue
		}
		; guarded method
		if (guarded) {
			l_array.push(param_iteratee.call(value))
			continue
		}
		; functor
		if (this.isFunction(param_iteratee)) {
			l_array.push(param_iteratee.call(value, key, l_collection))
		}
	}
	return l_array
}


; tests
fn_square(n)
{
	return n * n
}

assert.test(A.map([4, 8], Func("fn_square")), [16, 64])
assert.test(A.map({ "a": 4, "b": 8 }, Func("fn_square")), [16, 64])
assert.test(A.map({ "a": 4, "b": 8 }), [4, 8])

; The A.property shorthand
assert.label(".property shorthand")
users := [{ "user": "barney" }, { "user": "fred" }]
assert.test(A.map(users, "user"), ["barney", "fred"])

; omit
assert.label("call own biga.ahk function")
assert.test(A.map([" hey ", "hey", " hey	"], A.trim), ["hey", "hey", "hey"])

assert.label("call with 2 parameters")
assert.test(A.map([1, 2], Func("fn_map2")), ["1-1", "2-2"])
fn_map2(param1, param2)
{
	return param1 "-" param2
}

assert.label("call with 3 parameters")
assert.test(A.map([1, 2], Func("fn_map3")), ["1-1-1", "2-2-1"])
fn_map3(param1, param2, param3)
{
	return param1 "-" param2 "-" param3[1]
}

assert.label("default .identity argument")
assert.test(A.map([1, 2, 3]), [1, 2, 3])
