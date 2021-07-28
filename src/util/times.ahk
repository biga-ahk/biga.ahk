times(param_n,param_iteratee:="__identity") {
	if (!this.isNumber(param_n)) {
		this._internal_ThrowException()
	}

	; prepare
	if (this.startsWith(param_iteratee.name, this.base.__Class ".")) { ;if starts with "biga."
		guarded := this.includes(this._guardedMethods, strSplit(param_iteratee.name, ".").2)
		param_iteratee := param_iteratee.bind(this)
	}
	shorthand := this._internal_differenciateShorthand(param_iteratee)
	if (shorthand) {
		param_iteratee := this._internal_createShorthandfn(param_iteratee)
	}
	l_array := []

	; create
	loop, % param_n {
		l_array.push(param_iteratee.call(A_Index))
	}
	return l_array
}


; tests
assert.test(A.times(4, A.constant(0)), [0, 0, 0, 0])


; omit
assert.label("random array of numbers with boundFunc A.random")
boundFunc := A.random.bind(A, 99, 99, 0)
output := A.times(5, boundFunc)
assert.test(output, [99, 99, 99, 99, 99])

assert.label("random array of letters with boundFunc A.sample")
boundFunc := A.sample.bind(A, "abcdefghijklmnopqrstuvwxyz")
output := A.times(5, boundFunc)
assert.true(A.every(output, func("strLen"))) ;all strings longer than 0 chars

assert.label("default .identity argument")
assert.test(A.times(2), [1, 2])
