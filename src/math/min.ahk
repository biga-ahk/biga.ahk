min(param_array) {
	if (!IsObject(param_array)) {
		this._internal_ThrowException()
	}

	vMin := ""
	for Key, Value in param_array {
		if (vMin > Value || this.isUndefined(vMin)) {
			vMin := Value
		}
	}
	return vMin
}


; tests
assert.test(A.min([4, 2, 8, 6]), 2)
assert.test(A.min([]), "")


; omit
