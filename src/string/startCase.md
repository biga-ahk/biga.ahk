#### Arguments {docsify-ignore}

string (string): The string to convert.

#### Returns {docsify-ignore}
(string): Returns the start cased string.

#### Examples {docsify-ignore}

```autohotkey
A.startCase("--foo-bar--");
; => "Foo Bar"
 
A.startCase("fooBar");
; => "Foo Bar"
 
A.startCase("__FOO_BAR__");
; => "FOO BAR"
```
