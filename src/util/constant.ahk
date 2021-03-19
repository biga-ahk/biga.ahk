constant(param_value) {

	boundFunc := ObjBindMethod(this, "_internal_constant", param_value)
	return boundFunc
}

_internal_constant(param_value) {
	return param_value
}


; tests
object := A.times(2, A.constant({"a": 1}))
; => [{"a": 1}, {"a": 1}]


; omit
assert.test(object, [{"a": 1}, {"a": 1}])
functor := A.constant({ "a": 1 })
assert.test(functor.call({ "a": 1 }), {"a": 1})

assert.label("string")
object := A.times(2, A.constant("string"))
assert.test(object, ["string", "string"])
