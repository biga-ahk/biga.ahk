toLower(param_string) {
	if (!this.isString(param_string)) {
		this._internal_ThrowException()
	}

	; create
	stringLower, out, param_string
	return out
}


; tests
assert.test(A.toLower("--Foo-Bar--"), "--foo-bar--")
assert.test(A.toLower("fooBar"), "foobar")
assert.test(A.toLower("__FOO_BAR__"), "__foo_bar__")
