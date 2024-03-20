parseInt(param_string,param_radix:=0) {
	; Step 1: Convert the input string to a string
	inputString := "" param_string

	; Step 2: Remove leading whitespace from the input string
	inputString := this.trimStart(inputString, A_Tab A_Space)

	; Step 3: Determine the sign
	sign := 1
	if (inputString != "" && subStr(inputString, 1, 1) == "-") {
		sign := -1
		inputString := subStr(inputString, 2)
	} else if (inputString != "" && subStr(inputString, 1, 1) == "+") {
		inputString := subStr(S, 2)
	}

	; Step 4: Convert the radix to an integer
	radix := round(param_radix)

	; Step 5: Determine the radix and strip the prefix if necessary
	stripPrefix := true
	if (radix == 0) {
		radix := 10
	} else {
		if (radix < 2 || radix > 36) {
			return "" ;NAN
		}
		if (radix != 16) {
			stripPrefix := false
		}
	}

	if (stripPrefix && strLen(inputString) >= 2 && (subStr(inputString, 1, 2) == "0x" || subStr(inputString, 1, 2) == "0X")) {
		inputString := subStr(inputString, 3)
		radix := 16
	}

	; Step 6: Extract the valid digits and calculate the mathematical integer value
	validDigits := ""
	loop, % strLen(inputString) {
		char := subStr(inputString, A_Index, 1)
		if (!inStr(subStr("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ", 1, radix), char)) {
			break
		}
		validDigits .= char
	}
	if (validDigits == "") {
		return ""
	}
	
	mathInt := 0
	loop, % strLen(validDigits) {
		digit := subStr(validDigits, A_Index, 1)
		mathInt := mathInt * radix + (("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" ~= "i)" digit) - 1)
	}

	; Step 7: Return the final result
	return sign * mathInt
}


; tests
assert.test(A.parseInt("08"), 8)
assert.test(A.map(["6", "08", "10"], A.parseInt), [6, 8, 10])


; omit
assert.test(A.parseInt("0"), 0)
assert.test(A.parseInt(" 0"), 0)
assert.test(A.parseInt("	200"), 200)
assert.test(A.parseInt(" 200"), 200)

assert.label("decimal places")
assert.test(A.parseInt("1.0"), 1)
assert.test(A.parseInt("1.0001"), 1)

assert.label("with leading space")
assert.test(A.parseInt(" 10"), 10)
assert.label("with comma")
assert.test(A.parseInt("10,00"), 10)
assert.label("with space")
assert.test(A.parseInt("10 00"), 10)
assert.label("with special character")
assert.test(A.parseInt("10+10"), 10)
assert.label("with periods")
assert.test(A.parseInt("9.000.000"), 9)

assert.label("invalid input")
assert.test(A.parseInt(" "), "")

assert.label("Radix 16")
assert.test(A.parseInt("FF", 16), 255)
assert.label("Radix 2 (binary)")
assert.test(A.parseInt(101010, 2), 42)
assert.label("Radix 16")
assert.test(A.parseInt("0xFF", 16), 255)
assert.label("Radix 2")
assert.test(A.parseInt("0b101010", 2), 0)
assert.label("Radix 10")
assert.test(A.parseInt("0d42", 10), 0)
