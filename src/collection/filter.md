Iterates over elements of collection, returning an array of all elements predicate returns truthy for. The predicate is invoked with three arguments: (value, index|key, collection).

## Arguments

collection (Array|Object): The collection to iterate over.

[predicate=_.identity] (Function): The function invoked per iteration.

## Returns

(Array): Returns the new filtered array.

## Examples

```autohotkey
users := [{"user":"barney", "age":36, "active":true}, {"user":"fred", "age":40, "active":false}]
A.filter(users,Func("fn_filter1"))
; => [{"user":"barney", "age":36, "active":true}]
fn_filter1(param_interatee) {
    if (param_interatee.active) { 
        return true 
    }
}
A.filter(users,"active")
; => [{"user":"barney", "age":36, "active":true}]
```
