string (string): The string to modify.

pattern (RegExp|string): The pattern to replace.

replacement (string): The match replacement.

## Examples 

```autohotkey
A.replace("Hi Fred", "Fred", "Barney")
; => "Hi Barney"

A.replace("1234", "/(\d+)/", "numbers")
; => "numbers"
```