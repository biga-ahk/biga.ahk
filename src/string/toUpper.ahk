toUpper(param_string) {
	if (!this.isString(param_string)) {
		this._internal_ThrowException()
	}

	; create
	StringUpper, OutputVar, param_string
	return OutputVar
}


; tests
assert.test(A.toUpper("--foo-bar--"), "--FOO-BAR--")
assert.test(A.toUpper("fooBar"), "FOOBAR")
assert.test(A.toUpper("__foo_bar__"), "__FOO_BAR__")
