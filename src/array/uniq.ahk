uniq(param_collection) {
    if (!IsObject(param_collection)) {
        return false
    }

    ; prepare data
    tempArray := []
    l_array := []
    
    ; create the slice
    loop, % param_collection.Count() {
        printedelement := this.internal_MD5(this.printObj(param_collection[A_Index]))
        if (this.indexOf(tempArray, printedelement) == -1) {
            tempArray.push(printedelement)
            l_array.push(param_collection[A_Index])
        }
    }
    return l_array
}


; tests
assert.test(A.uniq([2, 1, 2]), [2, 1])


; omit
assert.test(A.uniq(["Fred", "Barney", "barney", "barney"]), ["Fred", "Barney", "barney"])
