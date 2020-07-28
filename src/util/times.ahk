times(param_n,param_iteratee:="__identity") {
	if (!this.isAlnum(n) && !this.isUndefinded(param_iteratee.Call(1))) {
		this._internal_ThrowException()
	}
	
	; prepare
	l_array := []

	; create
	loop, % param_n {
		l_array.push(param_iteratee.Call(A_Index))
	}
	return l_array
}


; tests
assert.test(A.times(4, A.constant(0)), [0, 0, 0, 0])


; omit
