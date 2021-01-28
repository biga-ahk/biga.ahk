max(param_array) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	l_max := ""
	for Key, Value in param_array {
		if (l_max < Value || this.isUndefined(l_max)) {
			l_max := Value
		}
	}
	return l_max
}


; tests
assert.test(A.max([4, 2, 8, 6]), 8)
assert.test(A.max([]), "")


; omit
