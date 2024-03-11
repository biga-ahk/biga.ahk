countBy(param_collection,param_predicate:="__identity") {

	; prepare
	shorthand := this._internal_detectShorthand(param_predicate, param_collection)
	if (shorthand) {
		param_predicate := this._internal_createShorthandfn(param_predicate, param_collection)
	}

	; create
	l_array := []
	for key, value in param_collection {
		vItaree := param_predicate.call(value)
		; use .hasKey because modern array methods such as .some can return true/1
		if (!l_array.hasKey(vItaree)) {
			; start counter at 1 if first encounter
			l_array[vItaree] := 1
		} else {
			l_array[vItaree]++
		}
	}
	return l_array
}


; tests
assert.test(A.countBy([6.1, 4.2, 6.3], func("floor")), {"4": 1, "6": 2})

; The A.property iteratee shorthand.
assert.test(A.countBy(["one", "two", "three"], A.size), {"3": 2, "5": 1})


; omit
assert.label("count word occurances")
wordOccurances := A.countBy(["one", "two", "three", "one", "two", "three"], A.toLower)
assert.equal(wordOccurances, {"one": 2, "two": 2, "three": 2})
wordOccurances := A.countBy(["one", "two", "three", "one", "two", "three"])
assert.equal(wordOccurances, {"one": 2, "two": 2, "three": 2})

assert.test(A.countBy(["one", "two", "three", "four"], A.size), {"3": 2, "4": 1, "5": 1})

assert.test(A.countBy(["one", "two", "three", "one", "two", "three", "four"], A.toLower), {"one": 2, "two": 2, "three": 2, "four": 1})
