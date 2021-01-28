min(param_array) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	l_min := ""
	for Key, Value in param_array {
		if (l_min > Value || this.isUndefined(l_min)) {
			l_min := Value
		}
	}
	return l_min
}


; tests
assert.test(A.min([4, 2, 8, 6]), 2)
assert.test(A.min([]), "")


; omit
