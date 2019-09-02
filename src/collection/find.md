Iterates over elements of collection, returning the first element predicate returns truthy for.

## Arguments

collection (Array|Object): The collection to inspect.

[predicate=_.identity] (Function): The function invoked per iteration.

[fromIndex=0] (number): The index to search from.

## Returns

(*): Returns the matched element, else undefined.

# Example
```autohotkey
users := [{ "user": "barney", "age": 36, "active": true }
    , { "user": "fred", "age": 40, "active": false }
    , { "user": "pebbles", "age": 1, "active": true } ]

A.find(users,"active")
; => { "user": "barney", "age": 36, "active": true }

A.find(users,Func("fn_filter1"))
fn_filter1(param_interatee) {
    if (param_interatee.active) { 
        return true 
    }
}
; => { "user": "barney", "age": 36, "active": true }

A.find(users,"active",2)
; => { "user": "pebbles", "age": 1, "active": true }
```