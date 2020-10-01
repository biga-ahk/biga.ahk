indexOf(param_array,param_value,fromIndex:=1) {
	if (!IsObject(param_array)) {
		this._internal_ThrowException()
	}
	 
	;  create
	for Index, Value in param_array {
		if (Index < fromIndex) {
			continue
		}
		if (this.isEqual(Value, param_value)) {
			return Index
		}
	}
	return -1
}


; tests
assert.test(A.indexOf([1, 2, 1, 2], 2), 2)

; Search from the `fromIndex`.
assert.test(A.indexOf([1, 2, 1, 2], 2, 3), 4)

assert.test(A.indexOf(["fred", "barney"], "pebbles"), -1)

StringCaseSense, On
assert.test(A.indexOf(["fred", "barney"], "Fred"), -1)


; omit
StringCaseSense, Off
