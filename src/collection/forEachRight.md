This method is like [A.forEach](/?id=foreach) except that it iterates over elements of collection from right to left.


## Aliases
`.eachRight`


## Arguments
collection (Array|Object): The collection to iterate over.

[iteratee:=.identity] (Function): The function invoked per iteration.


## Returns
(*): Returns collection.


## Examples

```autohotkey
A.forEach([1, 2], Func("fn_forEachFunc1"))
fn_forEachFunc1(value)
{
	msgbox, % value
}
; msgboxes 2 then 1

A.forEach({ "a": 1, "b": s2 }, Func("fn_forEachFunc2"))
fn_forEachFunc2(value, key)
{
	msgbox, % key
}
; msgboxes "b" then "a"
```
