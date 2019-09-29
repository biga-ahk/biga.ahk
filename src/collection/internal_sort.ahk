internal_sort(param_collection, param_iteratees := "name") {
    l_array := this.cloneDeep(param_collection)

        for Index, obj in l_array {
            out .= obj[param_iteratees] "+" Index "|" ; "+" allows for sort to work with just the value
            ; out will look like:   value+index|value+index|
        }

        Value := l_array[l_array.minIndex(), param_iteratees]
        if Value is number 
            type := " N "
        StringTrimRight, out, out, 1 ; remove trailing | 
        Sort, out, % "D| "
        arrStorage := []
        loop, parse, out, |
        arrStorage.insert(l_array[SubStr(A_LoopField, InStr(A_LoopField, "+") + 1)])
        l_array := arrStorage
        return l_array
}

; tests

users := [
  , { "name": "fred",   "age": 46 }
  , { "name": "barney", "age": 34 }
  , { "name": "bernard", "age": 36 }
  , { "name": "zeddy", "age": 40 }]

assert.test(A.internal_sort(users,"age"),[{"age":34,"name":"barney"},{"age":36,"name":"bernard"},{"age":40,"name":"zeddy"},{"age":46,"name":"fred"}])
assert.test(A.internal_sort(users,"name"),[{"age":34,"name":"barney"},{"age":36,"name":"bernard"},{"age":46,"name":"fred"},{"age":40,"name":"zeddy"}])
