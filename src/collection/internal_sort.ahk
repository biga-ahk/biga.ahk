internal_sort(param_collection, param_iteratees := "name") {
    a := this.cloneDeep(param_collection)

        for index, obj in a {
            out .= obj[param_iteratees] "+" index "|" ; "+" allows for sort to work with just the value
            ; out will look like:   value+index|value+index|
        }

        v := a[a.minIndex(), param_iteratees]
        if v is number 
            type := " N "
        StringTrimRight, out, out, 1 ; remove trailing | 
        Sort, out, % "D| "
        aStorage := []
        loop, parse, out, |
        aStorage.insert(a[SubStr(A_LoopField, InStr(A_LoopField, "+") + 1)])
        a := aStorage
        return a
}

; tests

users := [
  , { "name": "fred",   "age": 46 }
  , { "name": "barney", "age": 34 }
  , { "name": "bernard", "age": 36 }
  , { "name": "zeddy", "age": 40 }]

assert.test(A.internal_sort(users,"age"),[{"age":34,"name":"barney"},{"age":36,"name":"bernard"},{"age":40,"name":"zeddy"},{"age":46,"name":"fred"}])
assert.test(A.internal_sort(users,"name"),[{"age":34,"name":"barney"},{"age":36,"name":"bernard"},{"age":46,"name":"fred"},{"age":40,"name":"zeddy"}])
