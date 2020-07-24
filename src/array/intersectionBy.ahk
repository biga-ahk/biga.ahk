; ###incomplete###
intersectionBy(param_params*) {
	
	; prepare data
	oParams := []
	boundFunc := ""
	for Key, Value in param_params {
		if (IsObject(Value)) {
			; msgbox, % this._printObj(Value) " / " Value.call(1)
			oParams.push(this.cloneDeep(Value))
		}
		; check last item as possible function or shorthand
		if (Key == param_params.Count()) {
			if (!this.isUndefined(Value.call(1))) {
				msgbox, % "this was callable and returned" Value.call(1)
				boundFunc := Value.bind()
			}
			shorthand := this._internal_differenciateShorthand(Value, oParams)
			msgbox, % "last item in array " shorthand
		}
	}

	tempArray   := A.cloneDeep(param_arrays[1])
	l_array := []
	
	; create the slice
	for Key, Value in tempArray { ;for each value in first array
		for Key2, Value2 in oParams { ;for each array sent to the method
			if (A_Index == 1) {
				continue
			}
			; search entire array for value in first array
			if (this.indexOf(Value2, Value) != -1) {
				found := true
			} else {
				found := false
			}
		}
		if (found) {
			l_array.push(Value)
		}
	}
	return l_array
}


; tests
assert.test(A.intersectionBy([2.1, 1.2], [2.3, 3.4], A.floor), [2.1])
assert.test(A.intersectionBy([{"x": 1}], [{"x": 2}, {"x": 1}], "x"), [{"x": 1}])


; omit
assert.test(A.intersectionBy([2, 1], [2, 3], [1, 2], [2]), [2])
assert.test(A.intersectionBy(["hello", "hello"], []))
