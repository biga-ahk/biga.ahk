clone(param_value) {

	if (isObject(param_value)) {
		return param_value.clone()
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
var := 33
clone := A.clone(var)
clone++
assert.notEqual(var, clone)

assert.label("boolean value")
assert.test(A.clone(true), true)
assert.test(A.clone(false), false)

assert.label("undefined value")
assert.test(A.clone(""), "")

assert.label("number that is not 33")
assert.test(A.clone(0), 0)
assert.test(A.clone(2), 2)

assert.label("string")
assert.test(A.clone("abc"), "abc")

assert.label("array of multiple elements")
assert.test(A.clone([4, 5, 6]), [4, 5, 6])

assert.label("empty object")
assert.test(A.clone({}), {})

assert.label("empty array")
assert.test(A.clone([]), [])

assert.label("string containing special characters")
assert.test(A.clone("@#$%^&*()"), "@#$%^&*()")

; Test with a negative number:
assert.label("negative number")
assert.test(A.clone(-1), -1)
