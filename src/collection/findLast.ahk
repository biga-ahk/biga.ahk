findLast(param_collection,param_predicate) {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; create
	return this.find(this.reverse(param_collection), param_predicate)
}


; tests
assert.test(A.findLast([1, 2, 3, 4], func("fn_findLastFunc")), 3)
fn_findLastFunc(n)
{
	return mod(n, 2) == 1
}


; omit
assert.test(A.findLast([2, 4, 6, 7, 8], func("fn_findLastFunc")), 7)

assert.test(A.findLast([1, 2, 3, 4, 5, 6], func("fn_findLastFunc")), 5)
