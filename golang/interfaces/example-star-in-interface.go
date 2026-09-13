package main

import "fmt"

/**
 * Хочешь сказать, структура при каждом вызове метода без звёздочки в определении копируется?!
 * 🤖 DeepSeek: Да, именно так — копируется при каждом вызове
 */

type BigStruct struct {
	Data [1000]int // 8000 байт
	Name string
}

// Value receiver — копия
func (b BigStruct) ValueMethod() {
	fmt.Printf("Address inside ValueMethod: %p\n", &b)
}

// Pointer receiver — без копии
func (b *BigStruct) PointerMethod() {
	fmt.Printf("Address inside PointerMethod: %p\n", b)
}

func main() {
	big := BigStruct{}

	fmt.Printf("Address of big:              %p\n", &big)
	big.ValueMethod()   // Копия! Другой адрес
	big.PointerMethod() // Без копии! Тот же адрес
}
