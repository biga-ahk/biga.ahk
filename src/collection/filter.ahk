filter(para_collection,para_func) {
    this.info_Array := []
    Loop, % para_collection.MaxIndex() {
        if (para_func is string) {
            if (para_collection[A_Index][para_func]) {
                this.info_Array.push(para_collection[A_Index])
            }
        }
        if (IsFunc(para_func)) {
            if (%para_func%(para_collection[A_Index])) {
                this.info_Array.push(para_collection[A_Index])
            }
        }
        ; if (para_func.Count() > 0) {
        ;     for Key, Value in para_func {
        ;         msgbox, % Key
        ;         msgbox, % Value
        ;         if (para_collection[A_Index][para_func]) {
        ;             this.info_Array.push(para_collection[A_Index])
        ;         }
        ;     }
        ; }
    }
    return this.info_Array
}

; tests
users := [{"user":"barney", "age":36, "active":true}, {"user":"fred", "age":40, "active":false}]
assert.test(A.filter(users,Func("fn_filter1")), [{"user":"barney", "age":36, "active":true}])
fn_filter1(para_interatee) {
    if (para_interatee.active) { 
        return true 
    }
}

assert.test(A.filter([1,2,3,-10,1.9],Func("fn_filter2")), [2,3])
fn_filter2(para_interatee) {
    if (para_interatee >= 2) {
        return para_interatee
    }
    return false
}

assert.label("filter() shorthands")
assert.test(A.filter(users,"active"), [{"user":"barney", "age":36, "active":true}])

;     ;matches shorthand
; assert.test(A.filter(users,{"age": 36,"active":true}), {"user":"barney", "age":36, "active":true})
;     ;matchesProperty shorthand
; assert.test(A.filter(users,["active",true]), {"user":"barney", "age":36, "active":true})