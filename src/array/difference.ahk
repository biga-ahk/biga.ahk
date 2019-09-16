difference(param_array, param_values*) {
    if (!IsObject(param_array)) {
        throw { error: "Type Error", file: A_LineFile, line: A_LineNumber }
    }
    l_array := this.clone(param_array)

    for i, obj in param_values
    {
        loop, % obj.MaxIndex() {
            if (this.indexOf(l_array,obj[A_Index]) != -1) {
                l_array.RemoveAt(A_Index)
            }
        }
    }
    return l_array
}

; tests
assert.test(A.difference([2, 1], [2, 3]),[1])

assert.test(A.difference([2, 1], [3]),[2, 1])
