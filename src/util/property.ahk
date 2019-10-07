property(param_source) {

    ; prepare the data
    if (this.includes(param_source, ".")) {
        param_source := this.split(param_source, ".")
    }

    ; create the fn
    if (IsObject(param_source)) {
        keyArray := []
        for Key, Value in param_source {
            keyArray.push(Value) 
        }
        BoundFunc := ObjBindMethod(this, "internal_property", keyArray)
        return BoundFunc
    } else {
        BoundFunc := ObjBindMethod(this, "internal_property", param_source)
    return BoundFunc
    }
}

internal_property(param_property,param_itaree) {
    ; msgbox, % "called with " this.printObj(param_itaree) " AND`n" this.printObj(param_property)
    if (IsObject(param_property)) {
        for Key, Value in param_property {
            if (param_property.Count() == 1) {
                ; msgbox, % "dove deep and found: " ObjRawGet(param_itaree, Value)
                return % ObjRawGet(param_itaree, Value)
            } else if (param_itaree.hasKey(Value)){
                rvalue := this.internal_property(this.tail(param_property), param_itaree[Value])
            }
        }
        return rvalue
    }
    return % param_itaree[param_property]
}


; tests
objects := [{ "a": {"b": 2} }, { "a": {"b": 1} }]
assert.test(A.map(objects, A.property("a.b")), ["2", "1"])

objects := [{"name": "fred"}, {"name": "barney"}]
assert.test(A.map(objects, A.property("name")), ["fred", "barney"])
; assert.test(A.map(A.sortBy(objects, A.property(["a", "b"]))), [2, 1])


; omit
fn := A.property("a.b")
assert.test(fn.call({ "a": {"b": 2} }), "2")