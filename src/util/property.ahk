property(param_source) {

	; prepare
	if (this.includes(param_source, ".")) {
		param_source := strSplit(param_source, ".")
	}

	; create
	if (isObject(param_source)) {
		keyArray := []
		for key, value in param_source {
			keyArray.push(value)
		}
		boundFunc := ObjBindMethod(this, "internal_property", keyArray)
		return boundFunc
	} else {
		boundFunc := ObjBindMethod(this, "internal_property", param_source)
		return boundFunc
	}
}

internal_property(param_property,param_itaree) {
	if (isObject(param_property)) {
		for key, value in param_property {
			if (param_property.count() == 1) {
				; msgbox, % "dove deep and found: " ObjRawGet(param_itaree, value)
				return objRawGet(param_itaree, value)
			} else if (param_itaree.hasKey(value)){
				rvalue := this.internal_property(this.tail(param_property), param_itaree[value])
			}
		}
		return rvalue
	}
	return param_itaree[param_property]
}


; tests
objects := [{ "a": {"b": 2} }, { "a": {"b": 1} }]
assert.test(A.map(objects, A.property("a.b")), ["2", "1"])

objects := [{"name": "fred"}, {"name": "barney"}]
assert.test(A.map(objects, A.property("name")), ["fred", "barney"])


; omit
; assert.test(A.map(A.sortBy(objects, A.property(["a", "b"]))), [2, 1])
fn := A.property("a.b")
assert.test(fn.call({ "a": {"b": 2} }), "2")

fn := A.property("a")
assert.test(fn.call({ "a": 1, "b": 2 }), 1)
