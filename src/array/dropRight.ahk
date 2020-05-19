dropRight(param_array,param_n:=1) {
	if param_n is not number 
	{
		this.internal_ThrowException()
	}

	; prepare data
	if (IsObject(param_array)) {
		l_array := this.clone(param_array)
	}
	if (param_array is alnum) {
		l_array := StrSplit(param_array)
	}

	; create
	loop, % param_n
	{
		l_array.RemoveAt(l_array.Count())
	}
	; return empty array if empty
	if (l_array.Count() == 0) {
		return []
	}
	return l_array
}


; tests
assert.test(A.dropRight([1, 2, 3]), [1, 2])
assert.test(A.dropRight([1, 2, 3], 2), [1])
assert.test(A.dropRight([1, 2, 3], 5), [])
assert.test(A.dropRight([1, 2, 3], 0), [1, 2, 3])
assert.test(A.dropRight("fred"), ["f", "r", "e"])
assert.test(A.dropRight(100), ["1", "0"])

; omit
assert.test(A.dropRight([]), [])
