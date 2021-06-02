isCallable(param) {
	fn := numGet(&(_ := Func("InStr").bind()), "Ptr")
	return (isFunc(param) || (isObject(param) && (numGet(&param, "Ptr") = fn)))
}


; tests
boundFunc := Func("strLen").bind()
assert.true(A.isCallable(boundFunc))
assert.false(IsFunc(boundFunc))
assert.true(A.isCallable(A.isString))
assert.true(A.isCallable(A.matchesProperty("a", 1)))
assert.false(A.isCallable([1, 2, 3]))


; omit
assert.false(A.isCallable([]))
assert.false(A.isCallable({}))
assert.false(A.isCallable("string"))
