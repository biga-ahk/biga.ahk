invertBy(param_object,param_iteratee:="__identity") {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	l_obj := this.cloneDeep(param_object)
	l_newObj := {}

	; create
	for key, value in l_obj {
		if (this.isCallable(param_iteratee)) {
			vkey := param_iteratee.call(value)
		} else {
			vkey := value
		}

		if (!isObject(l_newObj[vkey])) {
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
