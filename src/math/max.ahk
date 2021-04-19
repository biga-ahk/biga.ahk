max(param_array) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	l_max := ""
	for key, value in param_array {
		if (l_max < value || this.isUndefined(l_max)) {
			l_max := value
		}
	}
	return l_max
}


; tests
assert.test(A.max([4, 2, 8, 6]), 8)
assert.test(A.max([]), "")


; omit
assert.label("associative array")
assert.test(A.max({"foo": 10, "bar": 20}), 20)
