once(param_func) {
	if (!this.isFunction(param_func)) {
		this._internal_ThrowException()
	}

	; create
	; Define and return the function object
	return objBindMethod(this, "_internal_once", param_func)
}

_internal_once(param_func, param_args*) {
	static called
	; Check if the function has been called before
	if (called == "") {
		; Set the gate to indicate that the function has been called
		called := true
		; Invoke the original function with the provided arguments
		return param_func.call(param_args*)
	} else {
		; If the function has been called before, return
		return
	}
}


; tests


; omit
initialize := A.once(func("fn_createApplication"))
assert.test(initialize.call(), "called")
assert.test(initialize.call(), "")

fn_createApplication() {
	return "called"
}
