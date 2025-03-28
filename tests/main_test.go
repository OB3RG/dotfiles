package main

import "testing"

func TestFactorial(t *testing.T) {
	testCases := []struct {
		input    int
		expected int
	}{
		{0, 1},
		{1, 1},
		{2, 2},
		{3, 6},
		{4, 24},
		{5, 120},
		{-1, 1}, //Test for negative input
		{-2, 1},
	}

	for _, tc := range testCases {
		actual := Factorial(tc.input)
		if actual != tc.expected {
			t.Errorf("Factorial(%d) = %d, expected %d", tc.input, actual, tc.expected)
		}
	}
}
