sortBy(param_collection,param_iteratees:="") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := this.cloneDeep(param_collection)

	; create
	; if called with a function
	if (IsFunc(param_iteratees)) {
		tempArray := []
		for Key, Value in param_collection {
			l_index := param_iteratees.call(param_collection[Key])
			param_collection[Key]._temp_bigaSortIndex := l_index
			tempArray.push(param_collection[Key])
		}
		l_array := this.sortBy(tempArray, "_temp_bigaSortIndex")
		for Key, Value in l_array {
			l_array[Key].delete("_temp_bigaSortIndex")
		}
		return l_array
	}

	; if called with shorthands
	if (isObject(param_iteratees)) {
		; sort the collection however many times is requested by the shorthand identity
		for Key, Value in param_iteratees {
			l_array := this.internal_sort(l_array, Value)
		}
	} else {
		l_array := this.internal_sort(l_array, param_iteratees)
	}
	return l_array
}

internal_sort(param_collection,param_iteratees:="") {
	l_array := this.cloneDeep(param_collection)

	if (param_iteratees != "") {
		; sort associative arrays
		for Index, obj in l_array {
			out .= obj[param_iteratees] "+" Index "|" ; "+" allows for sort to work with just the value
			; out will look like:   value+index|value+index|
		}
		lastValue := l_array[Index, param_iteratees]
	} else {
		; sort regular arrays
		for Index, obj in l_array {
			out .= obj "+" Index "|"
		}
		lastValue := l_array[l_array.Count()]
	}

	if lastValue is number
	{
		sortType := "N"
	}
	StringTrimRight, out, out, 1 ; remove trailing |
	Sort, out, % "D| " sortType
	arrStorage := []
	loop, parse, out, |
	{
		arrStorage.push(l_array[SubStr(A_LoopField, InStr(A_LoopField, "+") + 1)])
	}
	return arrStorage
}

; tests
assert.test(A.sortBy(["b", "f", "e", "c", "d", "a"]),["a", "b", "c", "d", "e", "f"])
users := [
  , { "name": "fred",   "age": 40 }
  , { "name": "barney", "age": 34 }
  , { "name": "bernard", "age": 36 }
  , { "name": "zoey", "age": 40 }]

assert.test(A.sortBy(users, "age"), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"zoey"}, {"age":40, "name":"fred"}])
assert.test(A.sortBy(users, ["age", "name"]), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zoey"}])
assert.test(A.sortBy(users, Func("fn_sortByFunc")), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zoey"}])
fn_sortByFunc(o) {
	return o.name
}


; omit
myArray := [3, 4, 2, 9, 4, 12, 2]
assert.test(A.sortBy(myArray),[2, 2, 3, 4, 4, 9, 12])

myArray := ["100", "333", "987", "54", "1", "0", "-263", "543"]
assert.test(A.sortBy(myArray),["-263", "0", "1", "54", "100", "333", "543", "987"])

enemies := [
	, {"name": "bear", "hp": 200, "armor": 20}
	, {"name": "wolf", "hp": 100, "armor": 12}]
sortedEnemies := A.sortBy(enemies, "hp")
assert.test(A.sortBy(enemies, "hp"), [{"name": "wolf", "hp": 100, "armor": 12}, {"name": "bear", "hp": 200, "armor": 20}])

users := [
  , { "name": "fred",   "age": 46 }
  , { "name": "barney", "age": 34 }
  , { "name": "bernard", "age": 36 }
  , { "name": "Zoey", "age": 40 }]
assert.test(A.sortBy(users,"age"),[{"age":34,"name":"barney"},{"age":36,"name":"bernard"},{"age":40,"name":"Zoey"},{"age":46,"name":"fred"}])
assert.test(A.sortBy(users,"name"),[{"age":34,"name":"barney"},{"age":36,"name":"bernard"},{"age":46,"name":"fred"},{"age":40,"name":"Zoey"}])
