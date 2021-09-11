reverse(param_collection) {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	l_collection := this.cloneDeep(param_collection)
	l_array := []

	; create
	while (l_collection.count() != 0) {
		l_array.push(l_collection.pop())
	}
	return l_array
}


; tests
assert.test(A.reverse(["a", "b", "c"]), ["c", "b", "a"])
assert.test(A.reverse([{"foo": "bar"}, "b", "c"]), ["c", "b", {"foo": "bar"}])
assert.test(A.reverse([[1, 2, 3], "b", "c"]), ["c", "b", [1, 2, 3]])

; omit
; ensure no mutation
reverseVar := [1,2,3]
assert.test(A.reverse(reverseVar), [3, 2, 1])
assert.test(reverseVar, [1,2,3])
