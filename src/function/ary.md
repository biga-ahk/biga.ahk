Creates a function that invokes `func`, with up to `n` arguments, ignoring any additional arguments.


## Arguments
func (Function): The function to cap arguments for.

[n:=func.maxParams] (number): The arity cap.


## Returns
(Function): Returns the new capped function.
