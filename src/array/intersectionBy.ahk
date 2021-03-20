; ###incomplete###
intersectionBy(param_params*) {

	; prepare
	oParams := []
	boundFunc := ""
	for key, value in param_params {
		if (isObject(value)) {
			; msgbox, % this._printObj(value) " / " value.call(1)
			oParams.push(this.cloneDeep(value))
		}
		; check last item as possible function or shorthand
		if (key == param_params.count()) {
			if (!this.isUndefined(value.call(1))) {
				msgbox, % "this was callable and returned" value.call(1)
				boundFunc := value.bind()
			}
			shorthand := this._internal_differenciateShorthand(value, oParams)
		}
	}

	tempArray   := A.cloneDeep(param_arrays[1])
	param_arrays.RemoveAt(1)
	l_array := []

	; create
	for key, value in tempArray { ;for each value in first array
		for key2, value2 in oParams { ;for each array sent to the method
			; search entire array for value in first array
			if (this.indexOf(value2, value) != -1) {
				found := true
			} else {
				break
				found := false
			}
		}
		if (found && this.indexOf(l_array, value) == -1) {
			l_array.push(value)
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
