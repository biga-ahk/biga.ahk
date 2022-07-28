snakeCase(param_string:="") {
	if (!this.isStringLike(param_string)) {
		this._internal_ThrowException()
	}

	; create
	l_string := this.trim(param_string, "-_")
	l_string := this.kebabCase(l_string)
	l_string := strReplace(l_string, "-", "_")
	return l_string
}


; tests
assert.test(A.snakeCase("Foo Bar"), "foo_bar")
assert.test(A.snakeCase("fooBar"), "foo_bar")
assert.test(A.snakeCase("--FOO-BAR--"), "foo_bar")


; omit
assert.test(A.snakeCase("  Foo-Bar--"), "foo_bar")
