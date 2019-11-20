shuffle(param_collection) {
    if (!IsObject(param_collection)) {
        this.internal_ThrowException()
    }

    ; prepare data
    l_array := this.clone(param_collection)
    l_shuffledArray := []

    ; create
    loop, % l_array.Count() {
        random := this.sample(l_array)
        index := this.indexOf(l_array, random)
        l_array.RemoveAt(index)
        l_shuffledArray.push(random)
    }
    return l_shuffledArray
}


; tests


; omit
shuffleTestVar := A.shuffle([1, 2, 3, 4])
assert.test(shuffleTestVar.Count(), 4)

shuffleTestVar := A.shuffle(["barney", "fred", "pebbles"])
assert.test(shuffleTestVar.Count(), 3)
