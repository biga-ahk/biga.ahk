get(param_object,param_path,param_defaultValue:="") {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	if (!isObject(param_path)) {
		; remove undefined elements from array
		param_path := this.compact(this.split(param_path, this._pathRegex))
	}

	; create
	returnValue := param_object[param_path*]
	if (returnValue == "") {
		returnValue := param_defaultValue
	}
	return returnValue
}


; tests
object := {"a": [{ "b": { "c": 3} }]}

assert.test(A.get(object, "a[1].b.c"), 3)
assert.test(A.get(object, ["a", "1", "b", "c"]), 3)
assert.test(A.get(object, "a.b.c", "default"), "default")


; omit
