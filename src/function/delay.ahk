delay(param_func,param_wait,param_args*) {
	if (!this.isFunction(param_func) || !this.isNumber(param_wait)) {
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
assert.label("return true")
boundFunc := A.random.bind(A, 99, 99, 0)
assert.true(A.delay(boundFunc, 1000))


A.delay(Func("fn_delayTest"), 10, "hello", "world")
fn_delayTest(msg, msg2) {
	global assert
	assert.group(".delay")
	assert.label("callback")
	assert.test(msg " " msg2, "hello world")
}
; same but as a boundfunc
boundfunc := Func("fn_delayTest").bind("hello", "world")
A.delay(boundfunc, 10)

A.delay(Func("fn_delayTest2"), 10)
fn_delayTest2() {
	global assert
	assert.group(".delay")
	assert.label("callback with zero parameters")
	assert.test("hello world", "hello world")
}
; same but as a boundfunc
boundfunc := Func("fn_delayTest2").bind()
A.delay(boundfunc, 10)
