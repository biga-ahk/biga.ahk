findLast(param_collection,param_predicate) {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; create
	return this.find(this.reverse(param_collection), param_predicate)
}


; tests
assert.test(A.findLast([1, 2, 3, 4], Func("fn_findLastFunc")), 3)
fn_findLastFunc(n)
{
	return mod(n, 2) == 1
}

; omit
