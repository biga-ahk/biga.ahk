sortBy(param_collection, param_iteratees) {
    l_array := this.cloneDeep(param_collection)
    Order := 1

    if (IsObject(param_iteratees)) {
        ; sort the collection however many times is requested by the shorthand identity
        for Key, Value in param_iteratees {
            l_array := this.sort(l_array, Value)
        }
    }

    ; if (IsFunc(param_iteratees)) {
    ;     temp_array := []
    ;     for Key, Value in param_collection {
    ;         temp_array.push(param_iteratees.__Call(param_collection[key]))
    ;     }
    ;     l_array := this.cloneDeep(temp_array)
    ;     temp_array := [] ; free memory
    ; }

    return l_array
}

; tests

users := [
  , { "name": "freddy",   "age": 48 }
  , { "name": "barney", "age": 36 }
  , { "name": "fred",   "age": 40 }
  , { "name": "barney", "age": 34 }]

assert.test(A.sortBy(users,["age", "name"]),[{"age":34,"name":"barney"},{"age":36,"name":"barney"},{"age":40,"name":"fred"},{"age":48,"name":"freddy"}])
