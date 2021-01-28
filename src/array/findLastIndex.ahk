findLastIndex(param_array,param_value,fromIndex:=1) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; create
	l_array := this.reverse(this.cloneDeep(param_array))
	l_count := this.size(l_array)
	l_foundIndex := this.findIndex(l_array, param_value, fromIndex)

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
testusers := ["barney","jane","pebbles","barney","bill"]
assert.test(A.findLastIndex(testusers, "barney"), 4)
assert.test(A.findLastIndex(testusers, "jane"), 2)
assert.test(A.findLastIndex(testusers, "bill"), 5)
assert.test(A.findLastIndex(testusers, "pebbles"), 3)
