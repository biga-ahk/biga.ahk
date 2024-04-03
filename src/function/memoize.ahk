memoize(param_func,param_resolver:="") {
	if (!this.isFunction(param_func)) {
		this._internal_ThrowException()
	}

	; create
	; Define and return the function object
	return objBindMethod(this, "_internal_memoize", param_func, param_resolver)
}

_internal_memoize(param_func, param_resolver, param_args*) {
	; Generate the cache key
	if (param_resolver == "") {
		cacheKey := this._internal_MD5(this._internal_stringify(param_args))
	} else {
		cacheKey := param_resolver.call(param_args*)
	}

	; Check if the result is cached
	if (this._cache.hasKey(cacheKey)) {
		return this._cache[param_func.name, cacheKey]
	}

	; Compute the result and cache it
	this._cache[param_func.name, cacheKey] := param_func.call(param_args*)
	return this._cache[param_func.name, cacheKey]
}

; tests
memoizedFibonacci := A.memoize(func("fn_fibonacci"))
assert.test(memoizedFibonacci.call(10), 55)
; Subsequent calls with the same argument will use the cached result
assert.test(memoizedFibonacci.call(10), 55)

fn_fibonacci(n) {
	if (n <= 1) {
		return n
	}
	return fn_fibonacci(n - 1) + fn_fibonacci(n - 2)
}


; omit
assert.label("cache leak over to other memoizations functions")
memoizedIsEven := A.memoize(func("fn_memoizeIsEven"))
fn_memoizeIsEven(param_n) {
	return (mod(param_n, 2) = 0)
}
assert.test(memoizedIsEven.call(2), true)
assert.test(memoizedIsEven.call(4), true)
assert.test(memoizedIsEven.call(6), true)
assert.test(memoizedIsEven.call(10), true)
assert.test(A._cache["fn_fibonacci"].count(), 1, "cache has {{2}} items")
assert.test(A._cache["fn_memoizeIsEven"].count(), 4, "cache has {{4}} items")
assert.test(memoizedIsEven.call(2), true)
assert.test(memoizedIsEven.call(4), true)
assert.test(memoizedIsEven.call(6), true)
assert.test(memoizedIsEven.call(10), true)
assert.test(A._cache["fn_memoizeIsEven"].count(), 4, "cache still has {{4}} items")

assert.label("with multiple parameters")
memoizedTest := A.memoize(func("fn_memoizeTest"))
fn_memoizeTest(para1, para2, para3) {
	return biga.max([para1, para2, para3])
}
assert.test(memoizedTest.call(2, 5, 10), 10)
assert.test(memoizedTest.call(2, 5, 10), 10)
assert.test(memoizedTest.call(99, 44, 22), 99)
assert.test(memoizedTest.call(99, 44, 22), 99)
assert.test(A._cache["fn_memoizeTest"].count(), 2, "cache still has {{2}} items")
