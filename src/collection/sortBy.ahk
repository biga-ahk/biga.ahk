sortBy(param_collection,param_iteratees:="__identity") {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}
	; prepare
	if (this.startsWith(param_iteratees.name, this.__Class ".")) { ;if starts with "biga."
		param_iteratees := param_iteratees.bind(this)
	}
	l_array := []

	; create
	; no param_iteratees
	if (param_iteratees == "__identity") {
		return this._internal_sort(param_collection)
	}
	; property
	if (this.isStringLike(param_iteratees)) {
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


_internal_sort(param_collection, param_iteratees := "") {
	out := ""
	sortType := ""

	; Determine if sorting associative arrays or regular arrays
	if (param_iteratees != "") {
		; Associative arrays
		for index, obj in param_collection {
			out .= obj[param_iteratees] "+" index "|"
			; Store the last value for sorting type determination
			lastvalue := obj[param_iteratees]
		}
	} else {
		; Regular arrays
		for index, obj in param_collection {
			out .= obj "+" index "|"
			; Store the last value for sorting type determination
			lastvalue := obj
		}
	}

	; Determine the sorting type based on the last value encountered
	if (this.isNumber(lastvalue)) {
		sortType := "N"
	}

	; Perform sorting
	sort, out, % "D| " sortType
	; Remove the trailing "|" from the output
	out := subStr(out, 1, strlen(out) - 1)
	; Initialize an array to store sorted values
	arrStorage := []
	; Parse the sorted output and push corresponding values to arrStorage
	loop, parse, out, |
	{
		arrStorage.push(param_collection[subStr(A_LoopField, inStr(A_LoopField, "+") + 1)])
	}
	return arrStorage
}

; tests
assert.test(A.sortBy(["b", "f", "e", "c", "d", "a"]),["a", "b", "c", "d", "e", "f"])
users := [{ "name": "fred", "age": 40 }
 , { "name": "barney", "age": 34 }
 , { "name": "bernard", "age": 36 }
 , { "name": "zoey", "age": 40 }]

assert.test(A.sortBy(users, "age"), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"zoey"}, {"age":40, "name":"fred"}])
assert.test(A.sortBy(users, ["age", "name"]), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zoey"}])
assert.test(A.sortBy(users, func("fn_sortByFunc")), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zoey"}])
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

assert.label("array of objects by hp")
enemies := [{"name": "bear", "hp": 200, "armor": 20}
	, {"name": "tiger", "hp": 1, "armor": 200}
	, {"name": "wolf", "hp": 100, "armor": 12}]
assert.test(A.sortBy(enemies, "hp"), [{"name": "tiger", "hp": 1, "armor": 200}, {"name": "wolf", "hp": 100, "armor": 12}, {"name": "bear", "hp": 200, "armor": 20}])
assert.label("array of objects by armor")
assert.test(A.sortBy(enemies, "armor"), [{"name": "wolf", "hp": 100, "armor": 12}, {"name": "bear", "hp": 200, "armor": 20}, {"name": "tiger", "hp": 1, "armor": 200}])

users := [{ "name": "fred", "age": 46 }
 , { "name": "barney", "age": 34 }
 , { "name": "bernard", "age": 36 }
 , { "name": "zoey", "age": 40 }]
assert.test(A.sortBy(users,"name"),[{"age":34,"name":"barney"},{"age":36,"name":"bernard"},{"age":46,"name":"fred"},{"age":40,"name":"zoey"}])

assert.label("non-existant key")
assert.test(A.sortBy(users, "null"), users)

assert.label("number key")
assert.test(A.sortBy(users, 1), users)

assert.label("default .identity argument")
assert.test(A.sortBy([2, 0, 1]), [0, 1, 2])

assert.label("with abnormal key values")
users := [{ "name": "fred", "age |[]-=!@#$%^&*()_+": 46 }
 , { "name": "barney", "age |[]-=!@#$%^&*()_+": 34 }]
assert.test(A.sortBy(users, "age |[]-=!@#$%^&*()_+"), [{"age |[]-=!@#$%^&*()_+":34, "name":"barney"}, {"age |[]-=!@#$%^&*()_+":46, "name":"fred"}])
