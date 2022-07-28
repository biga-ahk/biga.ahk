toUpper(param_string) {
	if (!this.isString(param_string)) {
		this._internal_ThrowException()
	}

	; create
	stringUpper, out, param_string
	return out
}


; tests
assert.test(A.toUpper("--foo-bar--"), "--FOO-BAR--")
assert.test(A.toUpper("fooBar"), "FOOBAR")
assert.test(A.toUpper("__foo_bar__"), "__FOO_BAR__")
