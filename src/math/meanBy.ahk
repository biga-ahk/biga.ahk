meanBy(param_array,param_iteratee:="__identity") {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	if (!IsFunc(param_iteratee)) {
		boundFunc := param_iteratee.Bind(this)
	}
	shorthand := this._internal_differenciateShorthand(param_iteratee, param_array)
	if (shorthand != false) {
		boundFunc := this._internal_createShorthandfn(param_iteratee, param_array)
	}

	; prepare
	if (l_paramAmmount == 3) {
		arrayClone := this.cloneDeep(param_array)
	}
	l_total := 0

	; run against every value in the array
	for Key, Value in param_array {
		; shorthand
		if (shorthand == ".property") {
			fn := this.property(param_iteratee)
			l_iteratee := fn.call(Value)
		}
		if (boundFunc) {
			l_iteratee := boundFunc.call(Value)
		}
		if (param_iteratee.maxParams == 1) {
			if (!boundFunc.call(Value)) {
				l_iteratee := param_iteratee.call(Value)
			}
		}
		l_total += l_iteratee
	}
	return l_total / param_array.Count()
}


; tests
objects := [{"n": 4}, {"n": 2}, {"n": 8}, {"n": 6}]
assert.test(A.meanBy(objects, Func("meanByFunc1")), 5)
meanByFunc1(o)
{
	return o.n
}

; The `A.property` iteratee shorthand.
assert.test(A.meanBy(objects, "n"), 5)

; omit
