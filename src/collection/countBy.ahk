countBy(param_collection,param_predicate:="__identity") {

	; prepare
	shorthand := this._internal_differenciateShorthand(param_predicate, param_collection)
	if (shorthand) {
		param_predicate := this._internal_createShorthandfn(param_predicate, param_collection)
	}

	; create
	l_array := []
	for key, value in param_collection {
		vItaree := param_predicate.call(value)
		if (!l_array[vItaree]) {
			; start counter at 1 if first encounter
			l_array[vItaree] := 1
		} else {
			l_array[vItaree]++
		}
	}
	return l_array
}


; tests
assert.test(A.countBy([6.1, 4.2, 6.3], Func("floor")), {"4": 1, "6": 2})

; The A.property iteratee shorthand.
assert.test(A.countBy(["one", "two", "three"], A.size), {"3": 2, "5": 1})


; omit
assert.label("count word occurances")
wordOccurances := A.countBy(["one", "two", "three", "one", "two", "three"], A.toLower)
assert.equal(wordOccurances, {"one": 2, "two": 2, "three": 2})
wordOccurances := A.countBy(["one", "two", "three", "one", "two", "three"])
assert.equal(wordOccurances, {"one": 2, "two": 2, "three": 2})