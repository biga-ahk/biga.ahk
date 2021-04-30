lowerCase(param_string:="") {
	if (!this.isStringLike(param_string)) {
		this._internal_ThrowException()
	}

	; create
	l_string := this.startCase(param_string)
	l_string := this.toLower(this.trim(l_string))
	return l_string
}


; tests
assert.test(A.lowerCase("--Foo-Bar--"), "foo bar")
assert.test(A.lowerCase("fooBar"), "foo bar")
assert.test(A.lowerCase("__FOO_BAR__"), "foo bar")


; omit
assert.test(A.lowerCase("  Foo-Bar--"), "foo bar")
