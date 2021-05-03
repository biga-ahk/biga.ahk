takeRight(param_array,param_n:=1) {
	if (!this.isNumber(param_n)) {
		this._internal_ThrowException()
	}

	; prepare
	if (isObject(param_array)) {
		param_array := this.clone(param_array)
	}
	if (this.isStringLike(param_array)) {
		param_array := strSplit(param_array)
	}
	l_array := []

	; create
	loop, % param_n	{
		if (param_array.count() == 0) {
			continue
		}
		vvalue := param_array.pop()
		l_array.push(vvalue)
	}
	; return empty array if empty
	if (l_array.count() == 0 || param_n == 0) {
		return []
	}
	return this.reverse(l_array)
}


; tests
assert.test(A.takeRight([1, 2, 3]), [3])
assert.test(A.takeRight([1, 2, 3], 2), [2, 3])
assert.test(A.takeRight([1, 2, 3], 5), [1, 2, 3])
assert.test(A.takeRight([1, 2, 3], 0), [])
assert.test(A.takeRight("fred"), ["d"])
assert.test(A.takeRight(100), ["0"])

; omit
assert.test(A.takeRight([]), [])
assert.test(A.takeRight("fred", 3), ["r","e","d"])
assert.test(A.takeRight("fred", 4), ["f","r","e","d"])
