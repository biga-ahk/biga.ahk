flip(param_func) {
	if (!this.isFunction(param_func)) {
		this._internal_ThrowException()
	}

	; create
	boundFunc := objBindMethod(this, "_internal_flip", param_func)
	return boundFunc
}

_internal_flip(param_func, param_args*) {
	param_args := this.reverse(param_args)
	return param_func.call(param_args*)
}

; tests
flippedFunc1 := A.flip(Func("inStr"))
assert.test(flippedFunc1.call("s", "string"), 1)

flippedFunc2 := A.flip(Func("fn_flipFunc"))
assert.test(flippedFunc2.call("a", "b", "c", "d"), ["d", "c", "b", "a"])

fn_flipFunc(arguments*) {
	return biga.toArray(arguments)
}


; omit
flippedFunc3 := A.flip(Func("fn_flipEmptyFunc"))
assert.test(flippedFunc3.call(), [])

fn_flipEmptyFunc() {
    return []
}
