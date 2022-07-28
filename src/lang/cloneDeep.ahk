cloneDeep(param_array) {

	objs := {}
	obj := param_array.clone()
	objs[&param_array] := obj ; save this new array
	for key, value in obj {
		if (isObject(value)) ; if it is a subarray
			obj[key] := objs[&value] ; if we already know of a refrence to this array
			? objs[&value] ; then point it to the new array
			: this.clone(value, objs) ; otherwise, clone this sub-array
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
