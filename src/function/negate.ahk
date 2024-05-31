negate(param_func) {
	if (!this.isFunction(param_func)) {
		this._internal_ThrowException()
	}

	; prepare
	if (param_n == "") {
		param_n := param_func.maxParams
	}

	; create
	boundFunc := objBindMethod(this, "_internal_negate", param_func)
	return boundFunc
}

_internal_negate(param_func, param_args*) {
	return !param_func.call(param_args*)
}

; tests
fn_isEven(n) {
	return (mod(n, 2) = 0)
}

assert.test(A.filter[1, 2, 3, 4, 5, 6], A.negate(func("fn_isEven")), [1, 3, 5])


; omit
negatedFunc := A.negate(func("fn_isEven"))
assert.false(negatedFunc.call(2))
