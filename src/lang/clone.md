Creates a shallow clone of value.

## Arguments

value (*): The value to clone.


## Returns

(*): Returns the cloned value.

## Example

```autohotkey
object := [{ "a": 1 }, { "b": 2 }]
shallowclone := A.clone(object)
object.a := 2

msgbox, % A.printObj(shallowclone)
; => [{ "a": 1 }, { "b": 2 }]
```
