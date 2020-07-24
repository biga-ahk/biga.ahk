escape(param_string:="") {
	if (IsObject(param_string)) {
		this._internal_ThrowException()
	}

	; prepare data
	HTMLmap := [["&","&amp;"], ["<","&lt;"], [">","&gt;"], ["""","&quot;"], ["'","&#39;"]]

	for Key, Value in HTMLmap {
		element := Value
		param_string := StrReplace(param_string, element.1, element.2, , -1)
	}
	return param_string
}


; tests
string := "fred, barney, & pebbles"
assert.test(A.escape(string), "fred, barney, &amp; pebbles")


; omit
assert.test(A.escape("&&&"), "&amp;&amp;&amp;")
