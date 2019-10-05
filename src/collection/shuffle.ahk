shuffle(param_collection) {
    if (!IsObject(param_collection)) {
        this.internal_ThrowException()
    }
    
    l_shuffledArray := []
    loop, % param_collection.MaxIndex() {
        Random, randomvar, 1, param_collection.MaxIndex()
        l_shuffledArray.push(param_collection.RemoveAt(randomvar))
    }
    return l_shuffledArray
}


; tests


; omit
shuffleTestVar := A.shuffle([1, 2, 3, 4])
assert.test(shuffleTestVar.Count(), 4)

shuffleTestVar := A.shuffle(["barney", "fred", "pebbles"])
assert.test(shuffleTestVar.Count(), 3)
