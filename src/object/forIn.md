Iterates over own enumerable keys of an object and invokes iteratee for each property. The iteratee is invoked with three arguments: (value, key, object). Iteratee functions may exit iteration early by explicitly returning false.


## Arguments
object (Object): The object to iterate over.

[iteratee:=A.identity] (Function): The function invoked per iteration.


## Returns
(*): Returns the resolved value.

## Example
```autohotkey
object := {"a": 1, "b": 2}

A.forIn(object, Func("fn_forInFunc"))

fn_forInFunc(value, key) {
	msgbox, % key
}
; => msgboxes "a" then "b"
```
