delay(param_func,param_wait,param_args*) {
	if (!this.isCallable(param_func) || !this.isNumber(param_wait)) {
		this._internal_ThrowException()
	}

	; prepare
	; do not bind when 0 arguments supplied
	if (param_args.count() == 0) {
		boundFunc := param_func
	} else {
		boundFunc := param_func.bind(param_args*)
	}

	; create
	setTimer, % boundFunc, % -1 * param_wait
	return true
}


; tests


; omit
A.delay(Func("fn_delayTest"), 30, "howdy", "stranger")
fn_delayTest(msg, gg) {
	msgbox, % msg gg
}


boundFunc := A.random.bind(A, 99, 99, 0)
A.delay(boundFunc, 1000)
