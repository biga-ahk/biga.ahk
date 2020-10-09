shuffle(param_collection) {
	if (!IsObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := this.clone(param_collection)

	; create
	l_index := l_array.Count()
	loop, % l_index - 1 {
		Random, randomIndex, 1, % l_index
		l_tempVar := l_array[l_index]
		l_array[l_index] := l_array[randomIndex]
		l_array[randomIndex] := l_tempVar
		l_index--
	}
    return l_array
}


; tests


; omit
shuffleTestVar := A.shuffle([1, 2, 3, 4])
assert.test(shuffleTestVar.Count(), 4)

shuffleTestVar := A.shuffle(["barney", "fred", "pebbles"])
assert.test(shuffleTestVar.Count(), 3)

shuffleTestVar := A.shuffle([{"x": 1}, {"x": 1}, {"x": 1}])
assert.test(shuffleTestVar.Count(), 3)
assert.test(shuffleTestVar[1], {"x": 1})
assert.test(shuffleTestVar[2], {"x": 1})
assert.test(shuffleTestVar[3], {"x": 1})

assert.label("shuffle - empty array")
assert.test(A.shuffle([]), [])

assert.label("shuffle - sparse arrays")
shuffleTestVar := A.shuffle({2: 1, 4: 1, 6: 1})
shuffleTestVar := A.map(A.compact(shuffleTestVar))
assert.test(shuffleTestVar.Count(), 3)
assert.test(shuffleTestVar[1], 1)
assert.test(shuffleTestVar[2], 1)
assert.test(shuffleTestVar[3], 1)
