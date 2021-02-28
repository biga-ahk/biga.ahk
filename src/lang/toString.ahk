toString(param_value) {

	if (isObject(param_value)) {
		return this.join(param_value, ",")
	} else {
		return "" param_value
	}
}


; tests
assert.test(A.toString(non_existant_var), "")
assert.test(A.toString(-0), "-0")
assert.test(A.toString([1, 2, 3]), "1,2,3")


; omit
