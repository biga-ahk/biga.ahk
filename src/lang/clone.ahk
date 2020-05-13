clone(param_value) {
	if (IsObject(param_value)) {
		return param_value.Clone()
	} else {
		return param_value
	}
}


; tests
object := [{ "a": 1 }, { "b": 2 }]
shallowclone := A.clone(object)
object.a := 2
assert.test(shallowclone, [{ "a": 1 }, { "b": 2 }])


; omit
var := 1
clone := A.clone(var)
clone++
assert.notequal(var, clone)
