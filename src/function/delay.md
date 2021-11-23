Invokes func after wait milliseconds. Any additional arguments are provided to func when it's invoked.


## Arguments
func (Function): The function to delay.

wait (number): The number of milliseconds to delay invocation.

[args] (...*): The arguments to invoke func with.


## Returns
(boolean): Returns true.


## Example
```autohotkey
A.delay(Func("fn_delayFunc"), 1000, "later")
fn_delayFunc(text) {
	msgbox, % text
}
; => msgboxes 'later' after one second.
```
