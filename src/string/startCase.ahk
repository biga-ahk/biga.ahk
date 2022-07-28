startCase(param_string:="") {
	if (!this.isStringLike(param_string)) {
		this._internal_ThrowException()
	}

	; create
	l_string := this.replace(param_string, "/[_ -]/", " ")

	; add space before each capitalized character
	regExMatch(l_string, "O)([A-Z])", RE_Match)
	if (RE_Match.count()) {
		loop, % RE_Match.count() {
			l_string := subStr(l_string, 1, RE_Match.pos(A_Index) - 1) " " subStr(l_string, RE_Match.pos(A_Index))
		}
	}
	; split the string into array and titlecase each element in the array
	l_array := strSplit(l_string, " ")
	loop, % l_array.count() {
		l_string := l_array[A_Index]
		stringUpper, l_string, l_string, T
		l_array[A_Index] := l_string
	}
	; join the string back together from titlecased array elements
	l_string := this.join(l_array, " ")
	l_string := trim(l_string)
	return l_string
}


; tests
assert.test(A.startCase("--foo-bar--"), "Foo Bar")
assert.test(A.startCase("fooBar"), "Foo Bar")
assert.test(A.startCase("__FOO_BAR__"), "Foo Bar")
