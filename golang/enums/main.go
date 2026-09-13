package main

import (
	"fmt"

	"enums/colors"
)

/**
 * Enum emulation in Go: unexported color type + Color interface.
 * Values are only accessible from outside via Red()/Green()/Blue()/Unknown(),
 * so the set of allowed values is controlled by the package author.
 */

func main() {
	all := []colors.Color{colors.Red(), colors.Green(), colors.Blue(), colors.Unknown()}

	for _, c := range all {
		fmt.Printf("%-12s id=%d\n", c.Name(), c.ID())
	}

	fmt.Println()
	fmt.Println("Red().Equals(Red())   =", colors.Red().Equals(colors.Red()))  // true
	fmt.Println("Red().Equals(Blue())  =", colors.Red().Equals(colors.Blue())) // false
}
