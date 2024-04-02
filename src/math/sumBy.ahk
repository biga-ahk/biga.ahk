sumBy(param_array,param_iteratee:="__identity") {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_detectShorthand(param_iteratee, param_array)
	if (shorthand) {
		param_iteratee := this._internal_createShorthandfn(param_iteratee, param_array)
	}
	l_total := 0

	; run against every value in the array
	for key, value in param_array {
		; functor
		if (this.isFunction(param_iteratee)) {
			l_iteratee := param_iteratee.call(value)
		}
		l_total += l_iteratee
	}
	return l_total
}


; tests
objects := [ {"n": 4 }, { "n": 2 }, { "n": 8 }, { "n": 6 } ]

assert.test(A.sumBy(objects, func("fn_sumByFunc")), 20)
fn_sumByFunc(o)
{
	return o.n
}

; The A.property iteratee shorthand
assert.test(A.sumBy(objects, "n"), 20)


; omit
assert.label("default .identity argument")
assert.test(A.sumBy([0, 1, 2]), 3)

assert.label("negative input")
assert.test(A.sumBy(objects, func("fn_sumByNegativeFunc")), -20)
fn_sumByNegativeFunc(o)
{
	return -o.n
}
