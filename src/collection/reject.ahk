reject(param_collection,param_predicate) {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_predicate, param_collection)
	if (shorthand != false) {
		boundFunc := this._internal_createShorthandfn(param_predicate, param_collection)
	}
	l_array := []

	; create
	for key, value in param_collection {
		; functor
		; predefined !functor handling (slower as it .calls blindly)
		if (IsFunc(param_predicate)) {
			if (!param_predicate.call(value)) {
				l_array.push(value)
			}
			continue
		}
		; shorthand
		if (shorthand != false) {
			if (!boundFunc.call(value)) {
				l_array.push(value)
			}
			continue
		}
		; predefined !functor handling (slower as it .calls blindly)
		vvalue := param_predicate.call(value)
		if (!vvalue) {
			l_array.push(value)
			continue
		}
	}
	return l_array
}


; tests
users := [{"user":"barney", "age":36, "active":false}, {"user":"fred", "age":40, "active":true}]

assert.test(A.reject(users, Func("fn_rejectFunc")), [{"user":"fred", "age":40, "active":true}])
fn_rejectFunc(o) {
	return !o.active
}

; The A.matches shorthand
assert.test(A.reject(users, {"age":40, "active":true}), [{"user":"barney", "age":36, "active":false}])

; The A.matchesProperty shorthand
assert.test(A.reject(users, ["active", false]), [{"user":"fred", "age":40, "active":true}])

; The A.property shorthand
assert.test(A.reject(users, "active"), [{"user":"barney", "age":36, "active":false}])


; omit
