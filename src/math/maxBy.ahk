maxBy(param_array,param_iteratee:="__identity") {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_iteratee, param_array)
	if (shorthand = ".property") {
		param_iteratee := this._internal_createShorthandfn(param_iteratee, param_array)
	}
	l_max := 0

	; run against every value in the array
	for key, value in param_array {
		; functor
		if (this.isCallable(param_iteratee)) {
			l_iteratee := param_iteratee.call(value)
		}
		if (l_iteratee > l_max) {
            l_max := l_iteratee
        }
	}
	return l_max
}


; tests
objects := [ {"n": 4 }, { "n": 2 }, { "n": 8 }, { "n": 6 } ]

assert.test(A.maxBy(objects, Func("fn_maxByFunc")), 8)
fn_maxByFunc(o)
{
    return o.n
}

; The A.property iteratee shorthand
assert.test(A.maxBy(objects, "n"), 8)

; omit
