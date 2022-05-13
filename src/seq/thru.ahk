; ###incomplete###
thru(param_value,param_interceptor:="__identity") {

	; prepare
	l_returnValue := param_value

	; create
	if (this.isFunction(param_interceptor)) {
		return param_interceptor.call(param_value)
	}
	return param_value
}


; tests
A.thru


; omit
