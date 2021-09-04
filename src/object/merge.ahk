merge(param_collections*) {
	if (!isObject(param_collections)) {
		this._internal_ThrowException()
	}

	result := param_collections[1]
	for index, obj in param_collections {
		if (A_Index == 1) {
			continue
		}
		result := this.internal_Merge(result, obj)
	}
	return result
}

internal_Merge(param_value1, param_value2) {

	; prepare
	combined := {}

	; create
	if(!isObject(param_value1) && !isObject(param_value2)) {
		; skip "" param_value1
		if (this.isUndefined(param_value1) && this.isUndefined(param_value2)) {
			return param_value2
		}
		; skip "" param_value2
		if (!this.isUndefined(param_value1) && this.isUndefined(param_value2)) {
			return param_value1
		}
		; otherwise, return the right side item
		return param_value2
	}

	; merge objects
	for key, value in param_value1 {
		combined[key] := this.internal_Merge(value, param_value2[key])
	}
	for key, value in param_value2 {
		if (!combined.hasKey(key)) {
			combined[key] := value
		}
	}
	return combined
}


; tests
object := {"options": [{"option1": true}]}
other := {"options": [{"option2": false}]}
assert.test(A.merge(object, other), {"options": [{"option1": true, "option2": false}]})

object := { "a": [{ "b": 2 }, { "d": 4 }] }
other := { "a": [{ "c": 3 }, { "e": 5 }] }
assert.test(A.merge(object, other), { "a": [{ "b": "2", "c": 3 }, { "d": "4", "e": 5 }] })


; omit
obj1 := [100, "Fred", true]
obj2 := [100, "Fred", false, true]
assert.test(A.merge(obj1, obj2), [100, "Fred", false, true])
