sample(param_collection) {
    return this.sampleSize(param_collection)
}

; tests

; omit
output := A.sample([1, 2, 3])
assert.test(output.length(),1)
assert.true(IsObject(output))
