findIndex(param_array,param_predicate,param_fromindex:=1) {
	if (!isObject(param_array) || !this.isNumber(param_fromindex)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := []
	shorthand := this._internal_differenciateShorthand(param_predicate, param_array)
	if (shorthand != false) {
		param_predicate := this._internal_createShorthandfn(param_predicate, param_array)
	}

	; create
	for index, value in param_array {
		if (param_fromIndex > A_Index) {
			continue
		}
		if (this.isCallable(param_predicate)) {
			if (param_predicate.call(value, index, param_array)) {
				return index
			}
		}
	}
	return -1
}


; tests
users := [ { "user": "barney", "age": 36, "active": true }
	, { "user": "fred", "age": 40, "active": false }
	, { "user": "pebbles", "age": 1, "active": true } ]

; The A.matches iteratee shorthand.
assert.test(A.findIndex(users, { "age": 1, "active": true }), 3)

; The A.matchesProperty iteratee shorthand.
assert.test(A.findIndex(users, ["active", false]), 2)

; The A.property iteratee shorthand.
assert.test(A.findIndex(users, "active"), 1)


; omit
StringCaseSense, On
assert.label("case sensitive")
assert.test(A.findIndex(["fred", "barney"], "Fred"), -1)
assert.test(A.findIndex([{"name": "fred"}, {"name": "barney"}], {"name": "barney"}), 2)
StringCaseSense, Off

assert.label("function")
assert.test(A.findIndex(users, Func("fn_findIndexFunc")), 2)
fn_findIndexFunc(o) {
	return o.user == "fred"
}

assert.label("fromIndex")
users := [{"user": "barney", "active": true}
	, {"user": "fred", "active": false}
	, {"user": "pebbles", "active": false}]
assert.test(A.findIndex(users, ["active", false], 3), 3)

assert.label("boundFunc")
employees := [{"name": "Mike Smith", "tenureYears": 4}, {"name": "Nath Samuel", "tenureYears": 2}]
boundFunc := Func("fn_checkNameTenure").bind("Mike Smith", 4)
assert.test(A.findIndex(employees, boundFunc), 1)

fn_checkNameTenure(name, minTenure, obj)
{
	if (obj.tenureYears >= minTenure) {
		return true
	}
}
