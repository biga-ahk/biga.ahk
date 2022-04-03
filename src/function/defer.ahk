; ###incomplete###
defer(param_func,param_args*) {

	; prepare
	boundFunc := param_func.bind(this, param_args*)

	; create
	setTimer, % boundFunc, % -500
	Thread, Priority, -2147483648
	Thread, NoTimers
}

_defer() {

}


; tests
A.defer(A.now())

A.defer(Func("fn_deferTest"), "howdy")
; omit
fn_deferTest(msg) {
	msgbox, % msg
	msgbox, % msg.1
}
