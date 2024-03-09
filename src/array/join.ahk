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

assert.label("Join an array of strings with a specified delimiter")
assert.test(A.join(["a", "b", "c"], "~"), "a~b~c")

assert.label("Join an array of strings with the default delimiter (comma)")
assert.test(A.join(["a", "b", "c"]), "a,b,c")

assert.label("Join an array of integers with a specified delimiter")
assert.test(A.join([1, 2, 3], "~"), "1~2~3")

assert.label("Join an array of mixed types with a specified delimiter")
assert.test(A.join(["a", 1, true], "~"), "a~1~1")

assert.label("Join an array with empty strings with a specified delimiter")
assert.test(A.join(["", "b", "", "d"], "~"), "~b~~d")

assert.label("Join an empty array should return an empty string")
assert.test(A.join([]), "")

assert.label("Join an array with a single element should return the element itself")
assert.test(A.join(["hello"]), "hello")

assert.label("Join an array with non-string elements should convert them to strings")
assert.test(A.join([1, true, "", non_existant_var]), "1,1,,")
