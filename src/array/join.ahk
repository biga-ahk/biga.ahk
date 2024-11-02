join(param_array,param_separator:=",") {
	if (!isObject(param_array) || isObject(param_separator)) {
		this._internal_ThrowException()
	}

	; create
	enum := param_array._newEnum()
	enum.next(_, result)
	while enum.next(_, item) {
		result .= param_separator item
	}
	return result
}


; tests
assert.test(A.join(["a", "b", "c"], "~"), "a~b~c")
assert.test(A.join(["a", "b", "c"]), "a,b,c")


; omit
assert.test(A.join({"first": 1, "second": 2, "third": 3}), "1,2,3")
assert.test(A.join({"first": 1, "second": 2, "third": 3}, "~"), "1~2~3")

assert.label("array of strings with a specified delimiter")
assert.test(A.join(["a", "b", "c"], "~"), "a~b~c")

assert.label("array of strings with the default delimiter (comma)")
assert.test(A.join(["a", "b", "c"]), "a,b,c")

assert.label("array of integers with a specified delimiter")
assert.test(A.join([1, 2, 3], "~"), "1~2~3")

assert.label("array of mixed types with a specified delimiter")
assert.test(A.join(["a", 1, true], "~"), "a~1~1")

assert.label("array with empty strings with a specified delimiter")
assert.test(A.join(["", "b", "", "d"], "~"), "~b~~d")

assert.label("empty array should return an empty string")
assert.test(A.join([]), "")

assert.label("array with a single element should return the element itself")
assert.test(A.join(["hello"]), "hello")

assert.label("array with non-string elements should convert them to strings")
assert.test(A.join([1, true, "", non_existant_var]), "1,1,,")

assert.label("With negative number keys")
assert.test(A.join({"-100": 1, "-1": 2, "-0": 3}), "3,2,1")
