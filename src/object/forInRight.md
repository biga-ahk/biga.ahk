This method is like [A.forIn](/?id=forin) except that it iterates over properties of object in the opposite order.


## Arguments
object (Object): The object to iterate over.

[iteratee:=.identity] (Function): The function invoked per iteration.


## Returns
(*): Returns the resolved value.

## Example
```autohotkey
object := [1, 2, 3]
A.forInRight(object, func("fn_forInRightFunc")

fn_forInRightFunc(value, key) {
	msgbox, % value
}
; => msgboxes "3", "2", then "1"
```
