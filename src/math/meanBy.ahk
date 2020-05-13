meanBy(param_array,param_iteratee:="__identity") {
	if (!IsObject(param_array)) {
		this.internal_ThrowException()
	}

	; data setup
	if (!IsFunc(param_iteratee)) {
		BoundFunc := param_iteratee.Bind(this)
	}
	shorthand := this.internal_differenciateShorthand(param_iteratee, param_array)
	if (shorthand != false) {
		boundFunc := this.internal_createShorthandfn(param_iteratee, param_array)
	}

	; prepare data
	if (l_paramAmmount == 3) {
		arrayClone := this.cloneDeep(param_array)
	}
	l_TotalVal := 0

	; run against every value in the array
	for Key, Value in param_array {
		; shorthand
		if (shorthand == ".property") {
			fn := this.property(param_iteratee)
			vIteratee := fn.call(Value)
		}
		if (BoundFunc) {
			vIteratee := BoundFunc.call(Value)
		}
		if (param_iteratee.MaxParams == 1) {
			if (!BoundFunc.call(Value)) {
				vIteratee := param_iteratee.call(Value)
			}
		}
		l_TotalVal += vIteratee 
	}
	return l_TotalVal / param_array.Count()
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
