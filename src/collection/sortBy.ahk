sortBy(param_collection, param_iteratees) {
    param_collection := this.cloneDeep(param_collection)
    Order := 1

    for index2, obj2 in param_collection {           
        for index, obj in param_collection {
            if (lastIndex = index)
                break
            if !(A_Index = 1) && ((Order = 1) ? (param_collection[prevIndex][param_iteratees] > param_collection[index][param_iteratees]) : (param_collection[prevIndex][param_iteratees] < param_collection[index][param_iteratees])) {    
               tmp := param_collection[index][param_iteratees] 
               param_collection[index][param_iteratees] := param_collection[prevIndex][param_iteratees]
               param_collection[prevIndex][param_iteratees] := tmp  
            }         
            prevIndex := index
        }     
        lastIndex := prevIndex
    }

    remove any blank items
    filtering := true
    while, (filtering) {
        loop, % param_collection.MaxIndex() {
            filtering := false
            if (StrLen(this.printObj(param_collection[A_Index])) < 2 ) {
                param_collection.RemoveAt(A_Index)
                filtering := true
            }
        }
    }
    return param_collection
}

; tests

users := [{ "name": "fred",   "age": 48 }
  , { "name": "barney", "age": 36 }
  , { "name": "fred",   "age": 40 }
  , { "name": "barney", "age": 34 }]

assert.test(A.sortBy(users,"age"),[{"age":34,"name":"fred"},{"age":36,"name":"barney"},{"age":40,"name":"fred"},{"age":48,"name":"barney"}])
assert.test(A.sortBy(users,"name"),[{"age":48,"name":"barney"},{"age":36,"name":"barney"},{"age":40,"name":"fred"},{"age":34,"name":"fred"}])
