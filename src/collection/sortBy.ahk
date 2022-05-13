sortBy(param_collection,param_iteratees:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}
	; prepare
	if (this.startsWith(param_iteratees.name, this.base.__Class ".")) { ;if starts with "biga."
		param_iteratees := param_iteratees.bind(this)
	}
	l_array := []

	; create
	; no param_iteratees
	if (param_iteratees == "__identity") {
		return this._internal_sort(param_collection)
	}
	; property
	if (this.isAlnum(param_iteratees)) {
		return this._internal_sort(param_collection, param_iteratees)
	}
	; own method or function
	if (this.isFunction(param_iteratees)) {
		for key, value in param_collection {
			l_array[A_Index] := {}
			l_array[A_Index].value := value
			l_array[A_Index].key := param_iteratees.call(value)
		}
		l_array := this._internal_sort(l_array, "key")
		return this.map(l_array, "value")
	}
	; shorthand/multiple keys
	if (isObject(param_iteratees)) {
		l_array := this.cloneDeep(param_collection)
		; sort the collection however many times is requested by the shorthand identity
		for key, value in param_iteratees {
			l_array := this._internal_sort(l_array, value)
		}
		return l_array
	}
	return -1
}


_internal_sort(param_collection,param_iteratees:="") {
	l_array := this.cloneDeep(param_collection)

	; associative arrays
	if (param_iteratees != "") {
		for Index, obj in l_array {
			out .= obj[param_iteratees] "+" Index "|" ; "+" allows for sort to work with just the value
			; out will look like: value+index|value+index|
		}
		lastvalue := l_array[Index, param_iteratees]
	} else {
		; regular arrays
		for Index, obj in l_array {
			out .= obj "+" Index "|"
		}
		lastvalue := l_array[l_array.count()]
	}

	if (this.isNumber(lastvalue)) {
		sortType := "N"
	}
	stringTrimRight, out, out, 1 ; remove trailing |
	sort, out, % "D| " sortType
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
 , { "name": "fred", "age": 40 }
 , { "name": "barney", "age": 34 }
 , { "name": "bernard", "age": 36 }
 , { "name": "zoey", "age": 40 }]

assert.test(A.sortBy(users, "age"), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"zoey"}, {"age":40, "name":"fred"}])
assert.test(A.sortBy(users, ["age", "name"]), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zoey"}])
assert.test(A.sortBy(users, Func("fn_sortByFunc")), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zoey"}])
fn_sortByFunc(o)
{
	return o.name
}

; sort using result of another method
assert.label("calling own method")
assert.test(A.sortBy(["ab", "a", " abc", "abc"], A.size), ["a", "ab", "abc", " abc"])

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
 , { "name": "fred", "age": 46 }
 , { "name": "barney", "age": 34 }
 , { "name": "bernard", "age": 36 }
 , { "name": "zoey", "age": 40 }]
assert.test(A.sortBy(users,"name"),[{"age":34,"name":"barney"},{"age":36,"name":"bernard"},{"age":46,"name":"fred"},{"age":40,"name":"zoey"}])


assert.label("default .identity argument")
assert.test(A.sortBy([2, 0, 1]), [0, 1, 2])
