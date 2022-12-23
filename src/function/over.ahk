over(params*) {
	; create
	boundFunc := this._internal_over.bind(this, params)
	return boundFunc
}

_internal_over(param_func, param_args) {
	l_output := []
	for key, value in param_func[1] {
		if (this.startsWith(value.name, this.__Class ".")) { ;if starts with "biga."
			value := value.bind(this)
		}
		l_output[key] := value.call(param_args)
	}
	return l_output
}

; tests
func := A.over([A.isBoolean, A.isNumber])
assert.test(func.call(10), [false, true])
assert.test(func.call(1), [true, true])
assert.test(func.call("string"), [false, false])


; omit
func := A.over([A.typeOf, A.typeOf])
assert.test(func.call([1,2,3]), ["object", "object"])
assert.test(func.call("C"), ["string", "string"])