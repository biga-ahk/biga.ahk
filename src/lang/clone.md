Creates a shallow clone of value. Supports cloning arrays, objects, numbers, strings.

## Arguments

value (*): The value to clone.


## Returns

(*): Returns the cloned value.

## Example

```autohotkey
object := [{ "a": 1 }, { "b": 2 }]
shallowclone := A.clone(object)
object.a := 2
A.printObj(object)
; => [{ "a": 2 }, { "b": 2 }]
A.printObj(shallowclone)
; => [{ "a": 1 }, { "b": 2 }]
```
