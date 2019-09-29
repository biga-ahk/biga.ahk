sortBy(param_collection, param_iteratees) {
    l_array := this.cloneDeep(param_collection)
    Order := 1

    if (IsObject(param_iteratees)) {
        ; sort the collection however many times is requested by the shorthand identity
        for Key, Value in param_iteratees {
            l_array := this.internal_sort(l_array, Value)
        }
    } else {
        l_array := this.internal_sort(l_array, param_iteratees)
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
  , { "name": "fred",   "age": 40 }
  , { "name": "barney", "age": 34 }
  , { "name": "bernard", "age": 36 }
  , { "name": "zeddy", "age": 40 }]


assert.test(A.sortBy(users, ["age", "name"]), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zeddy"}])
assert.test(A.sortBy(users, "age"), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zeddy"}])
; omit

enemies := [ 
    , {"name": "bear", "hp": 200, "armor": 20}
    , {"name": "wolf", "hp": 100, "armor": 12}]
sortedEnemies := A.sortBy(enemies, "hp")
assert.test(A.sortBy(enemies, "hp"), [{"name": "wolf", "hp": 100, "armor": 12}, {"name": "bear", "hp": 200, "armor": 20}])
