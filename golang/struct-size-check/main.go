package main

import (
	"fmt"
	"unsafe"
)

// color is a named integer type: identical layout to int
// (same idea as enums/colors/colors.go).
type color int

// Color mimics an enum: a struct with a single unexported field.
type Color struct {
	id color
}

// ColorNamed adds a string field — the size starts to differ from a plain int.
type ColorNamed struct {
	id   color
	name string
}

// Padded demonstrates alignment padding inserted between fields.
type Padded struct {
	b bool
	i int64
}

func main() {
	var cn ColorNamed
	var p Padded

	fmt.Println("=== single-value types ===")
	fmt.Printf("int                : %2d bytes\n", unsafe.Sizeof(int(0)))
	fmt.Printf("color (named int)  : %2d bytes\n", unsafe.Sizeof(color(0)))
	fmt.Printf("Color{id color}    : %2d bytes\n", unsafe.Sizeof(Color{}))
	fmt.Printf("*Color             : %2d bytes\n", unsafe.Sizeof((*Color)(nil)))
	fmt.Printf("struct{} (empty)   : %2d bytes\n", unsafe.Sizeof(struct{}{}))

	fmt.Println()
	fmt.Println("=== structs grow with fields ===")
	fmt.Printf("ColorNamed{id; name}: %2d bytes (color=%d + string=%d, no padding)\n",
		unsafe.Sizeof(cn), unsafe.Sizeof(color(0)), unsafe.Sizeof(""))
	fmt.Printf("  offset of .name   : %2d bytes\n", unsafe.Offsetof(cn.name))
	fmt.Printf("Padded{b bool; i int64}: %2d bytes (1 + 7 padding + 8)\n", unsafe.Sizeof(p))
	fmt.Printf("  offset of .i      : %2d bytes\n", unsafe.Offsetof(p.i))

	fmt.Println()
	fmt.Println("=== collections ===")
	fmt.Printf("[4]Color  : %2d bytes (4 * %d)\n", unsafe.Sizeof([4]Color{}), unsafe.Sizeof(Color{}))
	fmt.Printf("[]Color   : %2d bytes for the slice header (ptr+len+cap), data is on the heap\n",
		unsafe.Sizeof([]Color{}))
}
