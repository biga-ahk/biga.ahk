class biga {

	; --- Static Variables ---
	static throwExceptions := true
	static limit := -1
	static _guardedMethods := ["chunk", "every", "fill", "invert", "parseInt", "random", "trim", "reverse"]
	static _pathRegex := "/[.\[\]]/"

	; --- Instance Variables ---
	_uniqueId := 0

	; --- Static Methods ---
