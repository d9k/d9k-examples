package colors

import "fmt"

type color int

const (
	_ color = iota // 0 зарезервирован под «неизвестный» цвет (нулевое значение)
	red
	green
	blue
)

// Color — enum-структура: поля id/name невозвратны наружу,
// значения создаются только через Red()/Green()/Blue()/Unknown().
type Color struct {
	id color
}

func Unknown() Color {
	return Color{}
}

func Red() Color {
	return Color{id: red}
}

func Green() Color {
	return Color{id: green}
}

func Blue() Color {
	return Color{id: blue}
}

func (c Color) ID() int {
	return int(c.id)
}

func (c Color) Name() string {
	switch c.id {
	case red:
		return "Red"
	case green:
		return "Green"
	case blue:
		return "Blue"
	case 0:
		return "Unknown"
	}
	return fmt.Sprintf("Color(%d)", int(c.id))
}

func (c Color) Equals(in Color) bool {
	return c.ID() == in.ID()
}
