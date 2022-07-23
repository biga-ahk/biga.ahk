toPath(param_value) {
	; prepare
	if (!isObject(param_value)) {
		return this.compact(this.split(param_value, this._pathRegex))
	}
	return param_value
}


; tests
assert.test(A.toPath("a.b.c"), ["a", "b", "c"])
assert.test(A.toPath("a[1].b.c"), ["a", "1", "b", "c"])


; omit
assert.test(A.toPath("a"), ["a"])
assert.test(A.toPath(["a", "1", "b", "c"]), ["a", "1", "b", "c"])
assert.test(A.toPath(["a", "1", "b", "", "c"]), ["a", "1", "b", "", "c"])
