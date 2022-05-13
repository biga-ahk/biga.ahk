class biga {

	; --- Static Variables ---
	static throwExceptions := true
	static limit := -1
	static _guardedMethods := ["trim"]
	static _pathRegex := "/[.\[\]]/"

	; --- Instance Variables ---
	_uniqueId := 0

	; --- Static Methods ---
