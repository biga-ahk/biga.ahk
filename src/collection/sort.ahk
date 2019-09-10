sort(param_collection, param_iteratees := "name") {
    l_array := this.cloneDeep(param_collection)
    Order := 1

    for index2, obj2 in l_array {           
        for index, obj in l_array {
            if (lastIndex = index)
                break
            if !(A_Index = 1) && ((Order = 1) ? (l_array[prevIndex][param_iteratees] > l_array[index][param_iteratees]) : (l_array[prevIndex][param_iteratees] < l_array[index][param_iteratees])) {    
               tmp := l_array[index][param_iteratees] 
               l_array[index][param_iteratees] := l_array[prevIndex][param_iteratees]
               l_array[prevIndex][param_iteratees] := tmp  
            }         
            prevIndex := index
        }     
        lastIndex := prevIndex
    }

    ; remove any blank items if ahk array was made poorly
    if (l_array.Count() != param_collection.MaxIndex() || StrLen(this.printObj(l_array[1])) < 2 || StrLen(this.printObj(l_array[l_array.MaxIndex()])) < 2) {
        loop, % l_array.MaxIndex() {
            if (StrLen(this.printObj(l_array[A_Index])) < 2) {
                l_array.RemoveAt(A_Index)
            }
        }
    }
    return l_array
}

; tests

users := [
  , { "name": "fred",   "age": 48 }
  , { "name": "barney", "age": 36 }
  , { "name": "fred",   "age": 40 }
  , { "name": "barney", "age": 34 }]

assert.test(A.sort(users,"age"),[{"age":34,"name":"fred"},{"age":36,"name":"barney"},{"age":40,"name":"fred"},{"age":48,"name":"barney"}])
assert.test(A.sort(users,"name"),[{"age":48,"name":"barney"},{"age":36,"name":"barney"},{"age":40,"name":"fred"},{"age":34,"name":"fred"}])
