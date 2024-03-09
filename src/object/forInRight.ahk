forInRight(param_object,param_iteratee:="__identity") {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	l_object := this.reverse(param_object)

	; create
	this.forIn(l_object, param_iteratee)
	return param_object
}


; tests
object := [1, 2, 3]
assert.test(A.forInRight(object, func("fn_forInRightFunc")), object)

fn_forInRightFunc(value, key) {
	; msgbox, % value
}

; omit
