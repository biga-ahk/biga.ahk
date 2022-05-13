toPath(param_value) {
	if (!this.isString(param_value)) {
		this._internal_ThrowException()
	}

	; prepare
	if (!isObject(param_value)) {
		return this.compact(this.split(param_value, this._pathRegex))
	}
}


; tests
assert.test(A.toPath("a.b.c"), ["a", "b", "c"])
assert.test(A.toPath("a[1].b.c"), ["a", "1", "b", "c"])


; omit
