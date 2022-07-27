camelCase(param_string:="") {
	if (!this.isStringLike(param_string)) {
		this._internal_ThrowException()
	}

	; prepare
	l_parseChr := "/[_ -]+/"

	; create
	l_arr := this.compact(this.split(param_string, l_parseChr), l_parseChr)
	if (l_arr.count() > 1) {
		l_head := this.toLower(this.head(l_arr))
		l_tail := this.join(this.map(this.tail(l_arr), this.startCase), "")
	} else {
		l_head := this.toLower(this.head(param_string))
		l_tail := this.join(this.tail(param_string), "")
	}
	return l_head l_tail
}


; tests
assert.test(A.camelCase("--foo-bar--"), "fooBar")
assert.test(A.camelCase("fooBar"), "fooBar")
assert.test(A.camelCase("__FOO_BAR__"), "fooBar")


; omit
assert.test(A.camelCase("FooBar"), "fooBar")
assert.test(A.camelCase("_this_is_FOO_BAR__"), "thisIsFooBar")
