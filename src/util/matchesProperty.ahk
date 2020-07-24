matchesProperty(param_path,param_srcValue) {
	if (IsObject(param_srcValue)) {
		this._internal_ThrowException()
	}

	; create the property fn
	fnProperty := this.property(param_path)
	; create the fn
	boundFunc := ObjBindMethod(this, "internal_matchesProperty", fnProperty, param_srcValue)
	return boundFunc
}

internal_matchesProperty(param_property,param_matchvalue,param_itaree) {
	itareeValue := param_property.call(param_itaree)
	; msgbox, % "comparing " this._printObj(param_matchvalue) " to " this._printObj(itareeValue) " from(" this._printObj(param_itaree) ")"
	if (!this.isUndefined(itareeValue)) {
		if (itareeValue = param_matchvalue) {
			return true
		}
	}    
	return false
}


; tests
objects := [{ "a": 1, "b": 2, "c": 3 }, { "a": 4, "b": 5, "c": 6 }]
assert.test(A.find(objects, A.matchesProperty("a", 4)), { "a": 4, "b": 5, "c": 6 })
assert.test(A.filter(objects, A.matchesProperty("a", 4)), [{ "a": 4, "b": 5, "c": 6 }])

objects := [{ "a": {"b": 2} }, { "a": {"b": 1} }]
assert.test(A.find(objects, A.matchesProperty(["a", "b"], 1)), { "a": {"b": 1} })

; omit
fn := A.matchesProperty("a", 1)

assert.true(fn.call({ "a": 1, "b": 2, "c": 3 }))

fn := A.matchesProperty("b", 2)
assert.true(fn.call({ "a": 1, "b": 2, "c": 3 }))
assert.false(fn.call({ "a": 1 }))
assert.false(fn.call({}))
assert.false(fn.call([]))
assert.false(fn.call(""))
assert.false(fn.call(" "))

objects := [{ "options": {"private": true} }, { "options": {"private": false} }, { "options": {"private": false} }]
assert.test(A.filter(objects, A.matchesProperty("options.private", false)), [{ "options": {"private": false} }, { "options": {"private": false} }])
assert.test(A.filter(objects, A.matchesProperty(["options", "private"], false)), [{ "options": {"private": false} }, { "options": {"private": false} }])

objects := [{ "name": "fred", "options": {"private": true} }
	, { "name": "barney", "options": {"private": false} }
	, { "name": "pebbles", "options": {"private": false} }]
assert.test(A.filter(objects, A.matchesProperty("options.private", false)), [{ "name": "barney", "options": {"private": false} }, { "name": "pebbles", "options": {"private": false} }])
assert.test(A.filter(objects, A.matchesProperty(["options", "private"], false)), [{ "name": "barney", "options": {"private": false} }, { "name": "pebbles", "options": {"private": false} }])
