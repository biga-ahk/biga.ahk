uniq(param_collection) {
    if (!IsObject(param_collection)) {
        return false
    }
    temp_Array := []
    this.info_Array := []
    loop, % param_collection.Count() {
        printedelement := this.internal_MD5(this.printObj(param_collection[A_Index]))
        if (this.indexOf(temp_Array,printedelement) == -1) {
            temp_Array.push(printedelement)
            this.info_Array.push(param_collection[A_Index])
        }
    }
    return this.info_Array
}

; tests
assert.test(A.uniq([2, 1, 2]),[2, 1])

; omit

assert.test(A.uniq(["Fred", "Barney", "barney", "barney"]),["Fred", "Barney", "barney"])
