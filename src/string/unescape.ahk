unescape(param_string:="") {
	if (!this.isString(param_string)) {
		this._internal_ThrowException()
	}

	; prepare
	HTMLmap := [["&","&amp;"], ["<","&lt;"], [">","&gt;"], ["""","&quot;"], ["'","&#39;"]]

	for Key, Value in HTMLmap {
		element := Value
		param_string := StrReplace(param_string, element.2, element.1, , -1)
	}
	return param_string
}


; tests
string := "fred, barney, &amp; pebbles"
assert.test(A.unescape(string), "fred, barney, & pebbles")


; omit
assert.test(A.unescape("&amp;&amp;&amp;"), "&&&")
