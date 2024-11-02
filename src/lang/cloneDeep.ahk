cloneDeep(param_array) {

	; prepare
	objs := {}
	obj := param_array.clone()
	objs[&param_array] := obj
	; create
	for key, value in obj {
		; if it is a subarray
		if (isObject(value))
			; if we already know of a refrence to this array
			obj[key] := objs[&value]
			; then point it to the new array
			? objs[&value]
			; otherwise, clone this sub-array
			: this.cloneDeep(value, objs)
	}
	return obj
}


; tests
object := [{ "a": [[1, 2, 3]] }, { "b": 2 }]
deepclone := A.cloneDeep(object)
object[1].a := 2
; object
; => [{ "a": 2 }, { "b": 2 }]
; deepclone
; => [{ "a": [[1, 2, 3]] }, { "b": 2 }]


; omit
assert.test(deepclone, [{ "a": [[1, 2, 3]] }, { "b": 2 }])
assert.test(object, [{ "a": 2 }, { "b": 2 }])
