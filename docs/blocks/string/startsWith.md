Checks if string starts with the given target string.

## Arguments {docsify-ignore}
string (string): The string to inspect.

[target] (string): The string to search for.

[position=0] (number): The position to search from.

#### Returns {docsify-ignore}
(boolean): Returns true if string starts with target, else false.

#### Examples {docsify-ignore}
```autohotkey
A.startsWith("abc", "a")
; => true

A.startsWith("abc", "b")
; => false

A.startsWith("abc", "b", 2)
; => true
```