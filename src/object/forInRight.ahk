forInRight(param_object,param_iteratee:="__identity") {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; create
	this.forIn(this.reverse(param_object), param_iteratee)
	return param_object
}


; tests
object := [1, 2, 3]
assert.test(A.forInRight(object, func("fn_forInRightFunc")), object)

fn_forInRightFunc(value, key) {
	; msgbox, % value
}

; omit
assert.label("no mutation")
assert.test(object, [1, 2, 3])
