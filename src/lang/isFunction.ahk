isFunction(param) {
	fn := numGet(&(_ := Func("InStr").bind()), "Ptr")
	return (isFunc(param) || (isObject(param) && (numGet(&param, "Ptr") = fn)))
}


; tests
boundFunc := Func("strLen").bind()
assert.true(A.isFunction(boundFunc))
assert.false(IsFunc(boundFunc))
assert.true(A.isFunction(A.isString))
assert.true(A.isFunction(A.matchesProperty("a", 1)))
assert.false(A.isFunction([1, 2, 3]))


; omit
assert.false(A.isFunction([]))
assert.false(A.isFunction({}))
assert.false(A.isFunction("string"))
