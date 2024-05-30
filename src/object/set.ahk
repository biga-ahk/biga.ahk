set(param_object, param_path, param_value) {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	path_keys := this.toPath(param_path)
	current_object := param_object

	; create
	for index, key in path_keys {
		; Check if the current key exists in the object
		if (!current_object.hasKey(key)) {
			; If the key doesn't exist, create a new object or array
			current_object[key] := {}
		}
		; If it's the last key, set the value
		if (A_Index = path_keys.count()) {
			current_object[key] := param_value
		} else {
			; Update the reference for the next iteration
			current_object := current_object[key]
		}
	}
	return param_object
}


; tests
object := {"a": [{ "b": {"c": 3} }]}

assert.test(A.set(object, "a[1].b.c", 4), {"a": [{ "b": {"c": 4} }]})
assert.test(A.get(object, "a[1].b.c"), 4)
A.set(object, ["x", "1", "y", "z"], 5)
assert.test(A.get(object, ["x", "1", "y", "z"]), 5)

; omit
object := {"a": [{"b": {"c": 3}}]}
A.set(object, "a[1].b.d", 5)
assert.test(A.get(object, "a[1].b.d"), 5, "add new key to existing object")

object := {}
A.set(object, "a[1]", 1)
assert.test(object, {"a": [1]}, "set array index 0")

object := {}
A.set(object, "a[2].b", 2)
assert.test(object, {"a": [ ,{"b": 2}]}, "set nested array with index 2")

object := {"a": [{"b": {"c": 3}}]}
A.set(object, "a[1].b.c", 4)
assert.test(A.get(object, "a[1].b.c"), 4, "modify existing value")

object := {}
A.set(object, "x[1].y.z", 5)
assert.test(A.get(object, "x[1].y.z"), 5, "create nested path with array index and set value")

object := {}
A.set(object, ["x", "1", "y", "z"], 5)
assert.test(A.get(object, ["x", "1", "y", "z"]), 5, "set value with array path input")

object := {}
A.set(object, "a.b.c.d.e", 10)
assert.test(A.get(object, "a.b.c.d.e"), 10, "deep nested path creation")

object := {"a": {"b": {"c": {"d": {"e": 10}}}}}
A.set(object, "a.b.c.d.e", 20)
assert.test(A.get(object, "a.b.c.d.e"), 20, "modify deep nested value")

object := {}
A.set(object, "a[0].b.c[1].d", 30)
assert.test(A.get(object, "a[0].b.c[1].d"), 30, "complex nested path with arrays")
