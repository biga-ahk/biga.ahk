Creates a function that is restricted to invoking `func` once. Repeat calls to the function return the value of the first invocation.


## Arguments
func (Function): The function to restrict.


## Returns
(Function): Returns the new restricted function.


## Example
```autohotkey
initialize = A.once(func("fn_createApplication"));
initialize.call();
initialize.call();
; => `fn_createApplication` is invoked once
```