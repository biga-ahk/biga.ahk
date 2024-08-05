Creates a throttled function that only invokes `func` at most once per every `wait` milliseconds. The function is invoked with the last arguments provided to the throttled function. Subsequent calls to the throttled function return the result of the last invocation.


## Arguments
func (Function): The function to throttle.

[wait:=0] (number): The number of milliseconds to throttle invocations to.


## Returns
(Function): Returns the new throttled function.


## Example
```autohotkey
refresh := A.throttle(func("fn_updateGUI"), 1000);
refresh.call();
refresh.call();
; => `fn_updateGUI` is invokable once every 1000ms but will return the last value anytime called
```
