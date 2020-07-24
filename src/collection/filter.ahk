filter(param_collection,param_predicate) {
	if (!IsObject(param_collection)) {
		this._internal_ThrowException()
	}

	; data setup
	shorthand := this._internal_differenciateShorthand(param_predicate, param_collection)
	if (shorthand != false) {
		boundFunc := this._internal_createShorthandfn(param_predicate, param_collection)
	}
	l_array := []

	; create the slice
	for Key, Value in param_collection {
		; functor
		if (IsFunc(param_predicate)) {
			if (param_predicate.call(Value)) {
				l_array.push(Value)
			}
			continue
		}
		; predefined !functor handling (slower as it .calls blindly)
		vValue := param_predicate.call(Value)
		if (vValue) {
			l_array.push(Value)
			continue
		}
		; shorthand
		if (shorthand != false) {
			if (boundFunc.call(Value)) {
				l_array.push(Value)
			}
			continue
		}
	}
	return l_array
}


; tests
users := [{"user":"barney", "age":36, "active":true}, {"user":"fred", "age":40, "active":false}]

assert.test(A.filter(users, Func("fn_filter1")), [{"user":"barney", "age":36, "active":true}])
fn_filter1(param_interatee) {
	if (param_interatee.active) { 
		return true 
	}
}
 
; The A.matches shorthand
assert.test(A.filter(users, {"age": 36,"active":true}), [{"user":"barney", "age":36, "active":true}])

; The A.matchesProperty shorthand
assert.test(A.filter(users, ["active", false]), [{"user":"fred", "age":40, "active":false}])

;the A.property shorthand 
assert.test(A.filter(users, "active"), [{"user":"barney", "age":36, "active":true}])


; omit
assert.test(A.filter([1,2,3,-10,1.9], Func("fn_filter2")), [2,3])
fn_filter2(param_interatee) {
	if (param_interatee >= 2) {
		return param_interatee
	}
	return false
}
