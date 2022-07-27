Prints values to terminal or other standard output device. Can be a string, or any other object to be converted into a string before written.


## Arguments
values* (*): The values to print.


## Returns
(string): Returns values in one string; stringifying any objects.


## Example
```autohotkey
A.print([1, 2, 3])
; => "1:1, 2:2, 3:3"

msgbox, % A.print("object: ", [1, 2, 3])
; => msgboxes "object: 1:1, 2:2, 3:3"
```