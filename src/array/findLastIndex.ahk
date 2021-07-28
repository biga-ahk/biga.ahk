findLastIndex(param_array,param_value:="__identity",param_fromIndex:=1) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; create
	l_array := this.reverse(this.cloneDeep(param_array))
	l_count := this.size(l_array)
	l_foundIndex := this.findIndex(l_array, param_value, param_fromIndex)

	if (l_foundIndex < 0) {
		return -1
	} else {
		finalIndex := l_count + 1
		finalIndex := finalIndex - l_foundIndex
	}
	return finalIndex
}


; tests
users := [{"user": "barney", "active": true}
		, {"user": "fred", "active": false}
		, {"user": "pebbles", "active": false}]

assert.test(A.findLastIndex(users, {"user": "barney", "active": true}), 1)
assert.test(A.findLastIndex(users, ["active", true]), 1)
assert.test(A.findLastIndex(users, "active"), 1)


; omit
assert.label("default .identity argument")
assert.test(A.findLastIndex(["foo", 0, "bar"]), 3)
