random(param_lower:=0,param_upper:=1,param_floating:=false) {
	if (!this.isNumber(param_lower) || !this.isNumber(param_upper) || !this.isNumber(param_floating)) {
		this._internal_ThrowException()
	}

	; prepare
	if (param_lower > param_upper) {
		l_temp := param_lower
		param_lower := param_upper
		param_upper := l_temp
	}
	if (param_floating) {
		param_lower += 0.0
		param_upper += 0.0
	}

	; create
	random, vRandom, param_lower, param_upper
	return vRandom
}


; tests


; omit
output := A.random(0, 1)
assert.false(isObject(output))

; test that floating point is returned
output := A.random(0, 1, true)
assert.test(A.includes(output, "."), true)
