package main

// Factorial calculates the factorial of a given integer.
// It returns 1 for negative inputs (as convention).
func Factorial(n int) int {
	if n < 0 {
		return 1 // Convention for negative inputs
	}

	if n == 0 {
		return 1
	}

	result := 1
	for i := 1; i <= n; i++ {
		result *= i
	}
	return result
}
