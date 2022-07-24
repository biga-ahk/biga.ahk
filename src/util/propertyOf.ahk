propertyOf(param_object) {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; create
	boundFunc := ObjBindMethod(this, "internal_propertyOf", param_object)
	return boundFunc
}

internal_propertyOf(param_object,param_path) {
	return this.property(param_path).call(param_object)
}


; tests
array := [0, 1, 2]
object := {"a": array, "b": array, "c": array}
assert.test(A.map(["a[3]", "c[1]"], A.propertyOf(object)), [2, 0])

assert.test(A.map([["a", 3], ["c", 1]], A.propertyOf(object)), [2, 0])


; omit
