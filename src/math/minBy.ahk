minBy(param_array,param_iteratee:="__identity") {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_iteratee, param_array)
	if (shorthand) {
		param_iteratee := this._internal_createShorthandfn(param_iteratee, param_array)
	}
	l_min := ""

	for key, value in param_array {
		; functor
		if (this.isFunction(param_iteratee)) {
			l_iteratee := param_iteratee.call(value)
		}
		if (l_iteratee < l_min || this.isUndefined(l_min)) {
			l_min := l_iteratee
			l_return := value
		}
	}
	return l_return
}


; tests
objects := [ {"n": 4 }, { "n": 2 }, { "n": 8 }, { "n": 6 } ]

assert.test(A.minBy(objects, Func("fn_minByFunc")), { "n": 2 })
fn_minByFunc(o)
{
	return o.n
}

; The A.property iteratee shorthand
assert.test(A.minBy(objects, "n"), { "n": 2 })


; omit
assert.label("default .identity argument")
assert.test(A.minBy([0, 1, 2], {"age": 1, "active": true}), 0)
