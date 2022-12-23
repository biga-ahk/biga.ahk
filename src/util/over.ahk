over(param_iteratees:="__identity") {

	; prepare
	if (this.isObject(param_iteratees)) {
		for key, value in param_iteratees {
			; turn blank "" into .identity
			if (this.isUndefined(value)) {
				param_iteratees[key] := this.identity.bind(this)
			}
			if (this.startsWith(value.name, this.__Class ".")) { ;if starts with "biga."
				param_iteratees[key] := value.bind(this)
			}
		}
	}

	; create
	boundFunc := this._internal_over.bind(this, param_iteratees)
	return boundFunc
}

_internal_over(param_func, param_args*) {
	l_output := []
	for key, value in param_func {
		l_output[key] := value.call(param_args*)
	}
	return l_output
}

; tests
func := A.over([func("min"), func("max")])
assert.test(func.call(1, 2, 3, 4), [1, 4])

func := A.over([A.isBoolean, A.isNumber])
assert.test(func.call(10), [false, true])


; omit
assert.test(func.call(1), [true, true])
assert.test(func.call("string"), [false, false])


assert.label("defalt to .identity")
func := A.over([A.identity, A.typeOf])
assert.test(func.call([1,2,3]), [[1,2,3], "object"])
assert.test(func.call("C"), ["C", "string"])

assert.label("defalt to .identity")
func := A.over(["" , A.isNumber, _.isString])
assert.test(func.call(1), [1, true, true])
