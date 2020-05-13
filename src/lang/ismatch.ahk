isMatch(param_object,param_source) {
	for Key, Value in param_source {
		if (param_object[key] == Value) {
			continue
		} else {
			return false
		}
	}
	return true
}


; tests
object := { "a": 1, "b": 2, "c": 3 }
assert.true(A.isMatch(object, {"b": 2}))
assert.true(A.isMatch(object, {"b": 2, "c": 3}))

assert.false(A.isMatch(object, {"b": 1}))
assert.false(A.isMatch(object, {"b": 2, "z": 99}))