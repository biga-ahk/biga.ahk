nthArg(param_n:=1) {
	if (!this.isNumber(param_n)) {
		this._internal_ThrowException()
	}
	; prepare
	if (param_n == 0) {
		param_n := 1
	}

	; create
	if (param_n > 0) {
		boundFunc := objBindMethod(this, "internal_nthArg", param_n)
	} else {
		boundFunc := objBindMethod(this, "internal_nthArgReverse", abs(param_n))
	}
	return boundFunc
}

internal_nthArg(param_n, args*) {
	return args[param_n]
}
internal_nthArgReverse(param_n, args*) {
	args := this.reverse(args)
	return args[param_n]
}


; tests
func := A.nthArg(2)
assert.test(func.call("a", "b", "c", "d"), "b")

func := A.nthArg(-2)
assert.test(func.call("a", "b", "c", "d"), "c")

; omit
assert.label("default argument")
func := A.nthArg()
assert.test(func.call("a", "b", "c", "d"), "a")