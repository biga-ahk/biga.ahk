memoize(param_func, param_resolver:="") {
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
	if (this.cache.hasKey(cacheKey)) {
		return this.cache[cacheKey]
	}

	; Compute the result and cache it
	this.cache[cacheKey] := param_func.call(param_args*)
	return this.cache[cacheKey]
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
