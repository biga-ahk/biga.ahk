isFunction(param) {
	funcRefrence := numGet(&(_ := func("inStr").bind()), "ptr")
	return (isFunc(param) || (isObject(param) && (numGet(&param, "ptr") = funcRefrence)))
}


; tests
boundFunc := func("strLen").bind()
assert.true(A.isFunction(boundFunc))
assert.false(IsFunc(boundFunc))
assert.true(A.isFunction(A.isString))
assert.true(A.isFunction(A.matchesProperty("a", 1)))
assert.false(A.isFunction([1, 2, 3]))


; omit
assert.false(A.isFunction([]))
assert.false(A.isFunction({}))
assert.false(A.isFunction("string"))
