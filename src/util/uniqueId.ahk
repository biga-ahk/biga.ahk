uniqueId(param_prefix:="") {
	this._uniqueId++
	return param_prefix this._uniqueId
}


; tests
assert.test(A.uniqueId("contact_"), "contact_1")
assert.test(A.uniqueId(), 2)

; omit
