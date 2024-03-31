throttle(param_func, param_wait:=0) {
	if (!this.isFunction(param_func)) {
		this._internal_ThrowException()
	}

	; create
	; Define and return the function object
	return objBindMethod(this, "_internal_throttle", param_func, param_wait)
}

_internal_throttle(param_func, param_wait, param_args*) {
	static lastResult, lastArgs, lastCallTime := 0

	; Get the current time
	currentTime := A_TickCount

	; Check if enough time has passed since the last call
	if (currentTime - lastCallTime >= param_wait) {
		; Update the last call time
		lastCallTime := currentTime
		; Invoke the original function with the provided arguments
		if (this._internal_stringify(param_args) = "") {
			lastResult := param_func.call(lastArgs*)
			return lastResult
		}
		
		lastResult := param_func.call(param_args*)
		lastArgs := param_args
		; Return the result of the function invocation
		return lastResult
	} else {
		; If the function is not callable yet, return the last result
		return lastResult
	}
}

; tests


; omit
throttledFunc := A.throttle(Func("fn_throttle"), 500)
throttledFunc.call("hello world")
sleep, 500
throttledFunc.call()

fn_throttle(parameter) {
	return "hello world"
}