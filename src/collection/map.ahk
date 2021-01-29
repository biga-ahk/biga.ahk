map(param_collection,param_iteratee:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_iteratee, param_collection)
	if (shorthand == ".property") {
		param_iteratee := this.property(param_iteratee)
	}
	for Key, Value in param_collection {
		if (!this.isUndefined(param_iteratee.call(Value))) {
			thisthing := "function"
		}
		break
	}
	l_array := []

	; create
	for Key, Value in param_collection {
		if (param_iteratee == "__identity") {
			l_array.push(Value)
			continue
		}
		if (thisthing == "function") {
			l_array.push(param_iteratee.call(Value))
			continue
		}
		if (IsFunc(param_iteratee)) { ;if calling own method
			BoundFunc := param_iteratee.Bind(this)
			l_array.push(BoundFunc.call(Value))
		}
	}
	return l_array
}


; tests
fn_square(n) {
	return  n * n
}

assert.test(A.map([4, 8], Func("fn_square")), [16, 64])
assert.test(A.map({ "a": 4, "b": 8 }, Func("fn_square")), [16, 64])
assert.test(A.map({ "a": 4, "b": 8 }), [4, 8])

; The `A.property` shorthand
users := [{ "user": "barney" }, { "user": "fred" }]
assert.test(A.map(users, "user"), ["barney", "fred"])

; omit
assert.test(A.map([" hey ", "hey", " hey	"], A.trim), ["hey", "hey", "hey"])
