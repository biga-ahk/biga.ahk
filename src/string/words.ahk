words(param_string,param_pattern:="/\b\w+(?:'\w+)?\b/") {
	if (!this.isString(param_string) || !this.isString(param_pattern)) {
		this._internal_ThrowException()
	}

	l_string := param_string
	l_array := []
	if (l_needle := this._internal_JSRegEx(param_pattern)) {
		param_pattern := l_needle
	}
	l_needle := "O)" param_pattern
	while(RegExMatch(l_string, l_needle, RE_Match)) {
		tempString := RE_Match.value()
		l_array.push(tempString)
		l_string := SubStr(l_string, RE_Match.Pos()+RE_Match.Len())
	}
	return l_array
}


; tests
assert.test(A.words("fred, barney, & pebbles"), ["fred", "barney", "pebbles"])

assert.test(A.words("fred, barney, & pebbles", "/[^, ]+/"), ["fred", "barney", "&", "pebbles"])


; omit
assert.test(A.words("One, and a two, and a one two three"), ["One", "and", "a", "two", "and", "a", "one", "two", "three"])
asser.label("appostroies")
assert.test(A.words("it's I'd ok. ok' k'o."), ["it's", "I'd", "ok", "ok", "k'o"])
