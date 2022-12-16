join(param_array,param_sepatator:=",") {
	if (!isObject(param_array) || isObject(param_sepatator)) {
		this._internal_ThrowException()
	}

	; create
	enum := param_array._newEnum()
	enum.next(_, result)
	while enum.next(_, item) {
		result .= param_sepatator item
	}
	return result
}


; tests
assert.test(A.join(["a", "b", "c"], "~"), "a~b~c")
assert.test(A.join(["a", "b", "c"]), "a,b,c")


; omit
assert.test(A.join({"first": 1, "second": 2, "third": 3}), "1,2,3")
assert.test(A.join({"first": 1, "second": 2, "third": 3}, "~"), "1~2~3")
