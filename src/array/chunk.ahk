chunk(param_array,param_size:=1) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := []
	param_array := this.clone(param_array)

	; create
	; keep working till the parameter array is empty
	while (param_array.count() > 0) {
		l_innerArr := []
		; fill the inner array to the max size of the size parameter
		loop, % param_size {
			; exit loop if there is nothing left in parameter array to work with
			if (param_array.count() == 0) {
				break
			}
			l_innerArr.push(param_array.removeAt(1))
		}
	l_array.push(l_innerArr)
	}
	return l_array
}


; tests
assert.test(A.chunk(["a", "b", "c", "d"], 2), [["a", "b"], ["c", "d"]])
assert.test(A.chunk(["a", "b", "c", "d"], 3), [["a", "b", "c"], ["d"]])

; omit
var := [1,2,3]
A.chunk(var, 2)
assert.label("parameter mutation")
assert.test(var, [1,2,3])
