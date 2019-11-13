Produces a random number between the inclusive lower and upper bounds. If floating is true, or either lower or upper are floats, a floating-point number is returned instead of an integer. Uses AutoHotkey's pseudo-random [Random](https://www.autohotkey.com/docs/commands/Random.htm) command.


## Arguments
[lower:=0] (number): The lower bound.

[upper:=1] (number): The upper bound.

[floating:=false] (boolean): Specify returning a floating-point number.


## Returns
(number): Returns the random number.


## Example
```autohotkey
A.random(0, 5)
; => an integer between 0 and 5

A.random(5)
; => an integer between 0 and 5

A.random(1.2, 5.2);
; => a floating-point number between 1.2 and 5.2
```