shuffle(param_collection) {
	if (!IsObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := this.clone(param_collection)
	l_keys := this.keys(l_array)
	l_shuffledArray := []

	; create
	loop, % l_array.Count() {
		randomIndex := this.random(1, l_keys.Count())
		randomKey := l_keys[randomIndex]
		l_shuffledArray.push(l_array[randomKey])
		l_keys.RemoveAt(randomIndex)
	}
	return l_shuffledArray
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

assert.label("shuffle - check that sparse arrays work")
shuffleTestVar := A.shuffle({2: 1, 4: 1, 6: 1})
assert.test(shuffleTestVar.Count(), 3)
assert.test(shuffleTestVar[1], 1)
assert.test(shuffleTestVar[2], 1)
assert.test(shuffleTestVar[3], 1)
