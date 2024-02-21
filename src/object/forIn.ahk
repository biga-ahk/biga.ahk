forIn(param_object,param_iteratee:="__identity") {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	l_object := this.cloneDeep(param_object)
	if (param_iteratee == "__identity") {
		param_iteratee := this.identity().bind(param_object)
	}

	; create
	for key, value in param_object {
		if (this.isFunction(param_iteratee)) {
			if (param_iteratee.call(value, key, l_object) == false) {
				break
			}
		}
	}
	return param_object
}


; tests
object := {"a": 1, "b": 2}
assert.test(A.forIn(object, func("fn_forInFunc")), {"a": 1, "b": 2})

fn_forInFunc(value, key) {
	; msgbox, % key
}

; omit
