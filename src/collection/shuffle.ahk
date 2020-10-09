shuffle(param_collection) {
	if (!IsObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := this.clone(param_collection)

	; create
	i := l_array.Count()
	loop, % i - 1 {
		Random, j, 1, % i
		x := l_array[i]
		l_array[i] := l_array[j]
		l_array[j] := x
		i--
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
