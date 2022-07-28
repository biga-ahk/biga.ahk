upperFirst(param_string:="") {
	if (!this.isStringLike(param_string)) {
		this._internal_ThrowException()
	}

	; create
	return this.toUpper(this.head(param_string)) this.join(this.tail(param_string), "")
}


; tests
assert.test(A.upperFirst("fred"), "Fred")
assert.test(A.upperFirst("FRED"), "FRED")


; omit
assert.test(A.upperFirst("--foo-bar--"), "--foo-bar--")
assert.test(A.upperFirst("fooBar"), "FooBar")
assert.test(A.upperFirst("__FOO_BAR__"), "__FOO_BAR__")
