sortBy(param_collection,param_iteratees) {
    if (!IsObject(param_collection)) {
        this.internal_ThrowException()
    }

    l_array := this.cloneDeep(param_collection)
    ; Order := 1

    ; create the slice
    ; func
    if (IsFunc(param_iteratees)) {
        tempArray := []
        for Key, Value in param_collection {
            bigaIndex := param_iteratees.call(param_collection[Key])
            param_collection[Key].bigaIndex := bigaIndex
            tempArray.push(param_collection[Key])
        }
        l_array := this.sortBy(tempArray, "bigaIndex")
        for Key, Value in l_array {
            l_array[Key].Remove("bigaIndex")
        }
        return l_array
    }

    if (IsObject(param_iteratees)) {
        ; sort the collection however many times is requested by the shorthand identity
        for Key, Value in param_iteratees {
            l_array := this.internal_sort(l_array, Value)
        }
    } else {
        l_array := this.internal_sort(l_array, param_iteratees)
    }
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
assert.test(A.sortBy(users, Func("sortby1")), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zeddy"}])
sortby1(o) {
    return o.name
}


; omit
enemies := [ 
    , {"name": "bear", "hp": 200, "armor": 20}
    , {"name": "wolf", "hp": 100, "armor": 12}]
sortedEnemies := A.sortBy(enemies, "hp")
assert.test(A.sortBy(enemies, "hp"), [{"name": "wolf", "hp": 100, "armor": 12}, {"name": "bear", "hp": 200, "armor": 20}])
