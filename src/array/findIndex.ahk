findIndex(param_array,param_value,fromIndex:=1) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_value, param_array)
	if (shorthand != false) {
		boundFunc := this._internal_createShorthandfn(param_value, param_array)
	}
	if (isFunc(param_value)) {
		boundFunc := param_value
	}
	if (isObject(param_value) && !isFunc(param_value)) { ; do not convert objects that are functions
		vSearchingobjects := true
		param_value := this._printObj(param_value)
	}

	; create
	for Index, value in param_array {
		if (Index < fromIndex) {
			continue
		}

		if (shorthand == ".matchesProperty" || shorthand == ".property") {
			if (boundFunc.call(param_array[Index]) == true) {
				return Index
			}
		}
		if (vSearchingobjects) {
			value := this._printObj(param_array[Index])
		}
		if (isFunc(boundFunc)) {
			if (boundFunc.call(param_array[Index]) == true) {
				return Index
			}
		}
		if (this.isEqual(value, param_value)) {
			return Index
		}
	}
	return -1
}


; tests
assert.test(A.findIndex([1, 2, 1, 2], 2), 2)

; Search from the `fromIndex`.
assert.test(A.findIndex([1, 2, 1, 2], 2, 3), 4)

assert.test(A.findIndex(["fred", "barney"], "pebbles"), -1)

StringCaseSense, On
assert.test(A.findIndex(["fred", "barney"], "Fred"), -1)
assert.test(A.findIndex([{"name": "fred"}, {"name": "barney"}], {"name": "barney"}), 2)

users := [ { "user": "barney", "age": 36, "active": true }
	, { "user": "fred", "age": 40, "active": false }
	, { "user": "pebbles", "age": 1, "active": true } ]
assert.test(A.findIndex(users, Func("fn_findIndexFunc")), 1)
fn_findIndexFunc(o) {
	return o.user == "barney"
}


; omit
StringCaseSense, Off
assert.test(A.findIndex([{name: "fred"}, {name: "barney"}], {name: "fred"}), 1)

users := [{"user": "barney", "active": true}
	, {"user": "fred", "active": false}
	, {"user": "pebbles", "active": false}]

assert.test(A.findIndex(users, ["active", false]), 2)
