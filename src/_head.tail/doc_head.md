# Quick Start

See [Getting Started](https://biga-ahk.github.io/biga.ahk/#/getting-started) for installation, inclusion, and initializiation.

### Attributes

By default the following attributes are as follows:

`A.throwExceptions := true`
Wherever typeif errors can be detected, biga.ahk will throw an exception pointing out the location the error occurred. Set this to `false` if you would like your script to continue without being stopped by exceptions.

`A.limit := -1`
Determines the number of times strings will be replaced when using [.replace](#replace) with a string argument. Set this to `1` to get closer to a javascript experience.

<br><br>
