has(param_object,param_path) {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	if (this.isStringLike(param_path)) {
		l_path := this.toPath(param_path)
	} else {
		l_path := this.cloneDeep(param_path)
	}

	; create
	for key, value in l_path {
		if (!param_object.hasKey(value)) {
			return false
		}
		param_object := param_object[value]
	}
	return true
}


; tests
object := {"a": { "b": ""}}

assert.true(A.has(object, "a"))
assert.true(A.has(object, "a.b"))
assert.true(A.has(object, ["a", "b"]))
assert.false(A.has(object, "a.b.c"))

; omit
assert.label("no mutation")
assert.test(object, {"a": { "b": ""}})
