invertBy(param_object,param_iteratee:="__identity") {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	shorthand := this._internal_differenciateShorthand(param_iteratee, param_object)
	if (shorthand) {
		param_iteratee := this._internal_createShorthandfn(param_iteratee, param_object)
	}
	l_obj := this.cloneDeep(param_object)
	l_newObj := {}

	; create
	for key, value in l_obj {
		if (this.isFunction(param_iteratee)) {
			vkey := param_iteratee.call(value)
		}
		; create array at key if not encountered yet
		if (!l_newObj.hasKey(vkey)) {
			l_newObj[vkey] := []
		}
		l_newObj[vkey].push(key)
	}
	return l_newObj
}


; tests
object := {"a": 1, "b": 2, "c": 1}
assert.test(A.invertBy(object), {"1": ["a", "c"], "2":["b"]})

assert.test(A.invertBy(object, Func("invertByFunc")), {"group1": ["a", "c"], "group2": ["b"]})
invertByFunc(value)
{
	return "group" value
}


; omit
assert.label("do not mutate")
object := {"a": 1}
assert.test(A.invertBy(object), {1:["a"]})
assert.test(object, {"a": 1})

assert.label("blank object")
assert.test(A.invertBy({}), {})

assert.label("default .identity argument")
assert.test(A.invertBy([1, 2, 3]), {"1": [1], "2":[2], "3":[3]})
