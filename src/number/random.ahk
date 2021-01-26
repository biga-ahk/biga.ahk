random(param_lower:=0,param_upper:=1,param_floating:=false) {
	if (IsObject(param_lower) || IsObject(param_upper) || IsObject(param_floating)) {
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
	Random, vRandom, param_lower, param_upper
	return vRandom
}


; tests


; omit
output := A.random(0, 1)
assert.false(IsObject(output))

; test that floating point is returned
output := A.random(0, 1, true)
assert.test(A.includes(output, "."), true)
