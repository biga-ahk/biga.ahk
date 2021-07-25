identity(param_value) {
	return param_value
}


; tests
object := {"a": 1}
assert.test(A.identity(object), {"a": 1})


; omit
