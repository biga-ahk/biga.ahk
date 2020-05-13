reject(param_collection,param_predicate) {
    if (!IsObject(param_collection)) {
        this.internal_ThrowException()
    }

    ; create the slice
    return this.difference(param_collection, this.filter(param_collection, param_predicate))
}


; tests
users := [{"user":"barney", "age":36, "active":false}, {"user":"fred", "age":40, "active":true}]

assert.test(A.reject(users, Func("fn_reject1")), [{"user":"fred", "age":40, "active":true}])
fn_reject1(o) {
    return !o.active
}

; The A.matches shorthand
assert.test(A.reject(users, {"age":40, "active":true}), [{"user":"barney", "age":36, "active":false}])

; The A.matchesProperty shorthand
assert.test(A.reject(users, ["active", false]), [{"user":"fred", "age":40, "active":true}])

;the A.property shorthand 
assert.test(A.reject(users, "active"), [{"user":"barney", "age":36, "active":false}])


; omit
