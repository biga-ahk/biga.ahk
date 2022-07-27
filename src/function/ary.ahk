ary(param_func, param_n:="") {
	if (!this.isFunction(param_func)) {
		this._internal_ThrowException()
	}

	; prepare
	if (param_n == "") {
		param_n := param_func.maxParams
	}

	; create
	boundFunc := objBindMethod(this, "_internal_ary", param_func, param_n)
	return boundFunc
}

_internal_ary(param_func, param_n, param_args*) {
	param_args := this.slice(param_args, 1, param_n)
	return param_func.call(param_args*)
}

; tests
aryFunc := A.ary(Func("fn_aryFunc"), 2)
assert.test(aryFunc.call("a", "b", "c", "d"), ["a", "b"])

fn_aryFunc(arguments*) {
	return biga.toArray(arguments)
}


; omit
