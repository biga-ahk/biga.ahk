filter(param_collection,param_func) {
    l_array := []
    loop, % param_collection.MaxIndex() {
        if (param_func is string) {
            if (param_collection[A_Index][param_func]) {
                l_array.push(param_collection[A_Index])
            }
        }
        if (IsFunc(param_func)) {
            if (param_func.call(param_collection[A_Index])) {
                l_array.push(param_collection[A_Index])
            }
            continue
        }

        ; matches
        ; predefined !functor handling (slower as it .calls blindly)
        vValue := param_func.call(param_collection[A_Index])
        if (vValue) {
            if (param_func.call(param_collection[A_Index])) {
                l_array.push(param_collection[A_Index])
            }
        }

        ; matches shorthand
        ; if (param_func.Count() > 0) {
        ;     for Key, Value in param_func {
        ;         msgbox, % Key
        ;         msgbox, % Value
        ;         if (param_collection[A_Index][param_func]) {
        ;             l_array.push(param_collection[A_Index])
        ;         }
        ;     }
        ; }

        ; matchesProperty shorthand
        ; not yet
    }
    return l_array
}


; tests
users := [{"user":"barney", "age":36, "active":true}, {"user":"fred", "age":40, "active":false}]
assert.test(A.filter(users,"active"), [{"user":"barney", "age":36, "active":true}])

assert.test(A.filter(users,Func("fn_filter1")), [{"user":"barney", "age":36, "active":true}])
fn_filter1(param_interatee) {
    if (param_interatee.active) { 
        return true 
    }
}


; omit
assert.test(A.filter([1,2,3,-10,1.9],Func("fn_filter2")), [2,3])
fn_filter2(param_interatee) {
    if (param_interatee >= 2) {
        return param_interatee
    }
    return false
}

assert.label("filter() shorthands")
assert.test(A.filter(users,"active"), [{"user":"barney", "age":36, "active":true}])
;     ;matches shorthand
; assert.test(A.filter(users,{"age": 36,"active":true}), {"user":"barney", "age":36, "active":true})
;     ;matchesProperty shorthand
; assert.test(A.filter(users,["active",true]), {"user":"barney", "age":36, "active":true})