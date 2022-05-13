; ###incomplete###
intersectionBy(param_params*) {

	; prepare
	oParams := []
	boundFunc := ""
	for key, value in param_params {
		if (isObject(value)) {
			oParams.push(this.cloneDeep(value))
		}
		; check last item as possible function or shorthand
		if (key == param_params.count()) {
			if (this.isFunction(value)) {
				iterateeFunc := value.bind()
			}
			shorthand := this._internal_differenciateShorthand(value, oParams[1])
			if (shorthand) {
				iterateeFunc := this._internal_createShorthandfn(value, oParams[1])
			}
		}
	}
	tempArray := this.cloneDeep(oParams[1])
	oParams.removeAt(1)
	l_array := []

	; create
	for key, value in tempArray { ;for each value in first array
		vIteratee := iterateeFunc.call(value)
		found := false
		for key2, value2 in oParams { ;for each array sent to the method
			; search entire array for value in first array
			vIteratee2 := iterateeFunc.call(value)
			if (this.indexOf(value2, value) != -1) {
				found := true
			} else {
				found := false
				break
			}
		}
		if (found && this.indexOf(l_array, value) == -1) {
			l_array[vIteratee] := value
		}
	}
	return this.map(l_array)
}


; tests
assert.test(A.intersectionBy([2.1, 1.2], [2.3, 3.4], A.floor), [2.1])
assert.test(A.intersectionBy([{"x": 1}], [{"x": 2}, {"x": 1}], "x"), [{"x": 1}])


; omit
assert.test(A.intersectionBy([2, 1], [2, 3], [1, 2], [2]), [2])
assert.test(A.intersectionBy(["hello", "hello"]), ["hello"])
