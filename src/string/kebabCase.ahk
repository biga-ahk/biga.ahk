kebabCase(param_string:="") {
	if (!this.isStringLike(param_string)) {
		this._internal_ThrowException()
	}

	; create
	l_string := this.startCase(param_string)
	l_string := StrReplace(l_string, " ", "-")
	return l_string
}


; tests
assert.test(A.kebabCase("Foo Bar"), "foo-bar")
assert.test(A.kebabCase("fooBar"), "foo-bar")
assert.test(A.kebabCase("--FOO_BAR--"), "foo-bar")


; omit
assert.test(A.kebabCase("  Foo-Bar--"), "FOO-BAR")
