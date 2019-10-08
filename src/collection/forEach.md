Iterates over elements of collection and invokes iteratee for each element. The iteratee is invoked with three arguments: (value, index|key, collection). Iteratee functions may exit iteration early by explicitly returning false.


<!-- Aliases
_.each -->


## Arguments
collection (Array|Object): The collection to iterate over.

[iteratee=_.identity] (Function): The function invoked per iteration.


## Returns
(*): Returns collection.


## Examples 

```autohotkey
A.forEach([1, 2], Func("forEachFunc1")
forEachFunc1(value) {
    msgbox, % value
}
; msgboxes `1` then `2`

A.forEach({ "a": 1, "b": 2 }, Func("forEachFunc2")
forEachFunc2(value, key) {
    msgbox, % key
}
msgboxes "a" then "b"
```
