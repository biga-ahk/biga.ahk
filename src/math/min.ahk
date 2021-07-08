min(param_array) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	l_min := ""
	for key, value in param_array {
		if (value < l_min || this.isUndefined(l_min)) {
			l_min := value
		}
	}
	return l_min
}


; tests
assert.test(A.min([4, 2, 8, 6]), 2)
assert.test(A.min([]), "")


; omit
assert.label("associative array")
assert.test(A.min({"foo": 10, "bar": 20}), 10)
