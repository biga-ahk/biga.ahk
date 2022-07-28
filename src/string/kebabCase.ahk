kebabCase(param_string:="") {
	if (!this.isStringLike(param_string)) {
		this._internal_ThrowException()
	}

	; create
	l_string := this.trim(param_string, "- _")
	; add space before each capitalized character
	regExMatch(l_string, "O)([A-Z])", RE_Match)
	if (RE_Match.count()) {
		loop, % RE_Match.count() {
			l_string := subStr(l_string, 1, RE_Match.pos(A_Index) - 1) " " subStr(l_string, RE_Match.pos(A_Index))
		}
	}
	l_arr := this.split(l_string, "/\s/")
	if (l_arr.count() > 1) {
		l_string := this.join(this.compact(l_arr), "-")
	}
	l_string := this.toLower(l_string)
	l_string := strReplace(l_string, "_", "-")
	; l_string := strReplace(l_string, " ", "")
	return l_string
}


; tests
assert.test(A.kebabCase("Foo Bar"), "foo-bar")
assert.test(A.kebabCase("fooBar"), "foo-bar")
assert.test(A.kebabCase("--FOO_BAR--"), "foo-bar")


; omit
assert.test(A.kebabCase("  Foo-Bar--"), "foo-bar")
assert.test(A.kebabCase("foo  Bar"), "foo-bar")
