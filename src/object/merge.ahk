merge(param_collections*) {
    result := param_collections[1]
    for i, obj in param_collections {
        if(A_Index = 1) {
            continue 
        }
        result := this.internal_Merge(result, obj)
    }
    return result
}

internal_Merge(param_collection1, param_collection2) {
    if(!IsObject(param_collection1) && !IsObject(param_collection2)) {
        ; if only one OR the other exist, display them together. 
        if(param_collection1 = "" || param_collection2 = "") {
            return param_collection2 param_collection1
        }
        ; return only one if they are the same
        if (param_collection1 = param_collection2)
            return param_collection1
        ; otherwise, return them together as an object. 
        return [param_collection1, param_collection2]
    }

    ; initialize an associative array
    combined := {}

    for key, val in param_collection1 {
        combined[key] := this.internal_Merge(val, param_collection2[key])
    }
    for key, val in param_collection2 {
        if(!combined.HasKey(key)) {
            combined[key] := val
        }
    }
    return combined
}


; tests
object := {"options":[{"option1":"true"}]}
other := {"options":[{"option2":"false"}]}
assert.test(A.merge(object, other), {"options":[{"option1":"true", "option2":"false"}]})

object := { "a": [{ "b": 2 }, { "d": 4 }] }
other := { "a": [{ "c": 3 }, { "e": 5 }] }
assert.test(A.merge(object, other), { "a": [{ "b": "2", "c": 3 }, { "d": "4", "e": 5 }] })
