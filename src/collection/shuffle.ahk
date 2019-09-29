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
assert.notequal(A.shuffle([1, 2, 3, 4]),[4, 1, 3, 2])
users := ["barney", "fred", "fred", "fred", "pebbles"]
assert.notequal(A.shuffle(users),["pebbles", "fred", "barney", "fred", "fred"])
