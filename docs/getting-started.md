## Installation

In a terminal or command line:

```bash
npm install biga.ahk
```

In your code:

```autohotkey
#Include %A_ScriptDir%\node_modules
#Include biga.ahk\export.ahk
A := new biga()
msgbox, % A.join(["a", "b", "c"], " ")
; => "a b c"
```


## ahk considerations

> [!Tip]
> These are not set in stone. A final decision will be made before or on v1.0.0 


By default `A.throwExceptions := true` Wherever type errors can be detected, biga.ahk will throw an exception pointing out the location the error occurred. Set this to `false` if you would like your script to continue without being stopped by biga.ahk

By default `A.caseSensitive := false` Wherever possible biga.ahk will refer to this concerning case sensitive decisions and comparisons. Set this to `true` to get closer to the javascript experience

By default `A.limit := -1` Wherever possible biga.ahk will refer to this concerning limiting actions not specified by method arguments. Set this to `1` to get closer to the javascript experience
