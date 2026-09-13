package colors

import "testing"

func TestConstructorIDs(t *testing.T) {
	tests := []struct {
		name     string
		got      Color
		wantID   int
		wantName string
	}{
		{"Unknown", Unknown(), 0, "Unknown"},
		{"Red", Red(), 1, "Red"},
		{"Green", Green(), 2, "Green"},
		{"Blue", Blue(), 3, "Blue"},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := tt.got.ID(); got != tt.wantID {
				t.Errorf("ID() = %d, want %d", got, tt.wantID)
			}
			if got := tt.got.Name(); got != tt.wantName {
				t.Errorf("Name() = %q, want %q", got, tt.wantName)
			}
		})
	}
}

func TestZeroValueIsUnknown(t *testing.T) {
	var zero Color

	if !zero.Equals(Unknown()) {
		t.Errorf("zero Color should equal Unknown(), got ID=%d", zero.ID())
	}
	if got := zero.Name(); got != "Unknown" {
		t.Errorf("zero Color Name() = %q, want %q", got, "Unknown")
	}
}

func TestEquals(t *testing.T) {
	tests := []struct {
		name string
		a    Color
		b    Color
		want bool
	}{
		{"Red equals Red", Red(), Red(), true},
		{"Green equals Green", Green(), Green(), true},
		{"Unknown equals Unknown", Unknown(), Unknown(), true},
		{"Red not equals Blue", Red(), Blue(), false},
		{"Red not equals Unknown", Red(), Unknown(), false},
		{"Blue not equals Green", Blue(), Green(), false},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := tt.a.Equals(tt.b); got != tt.want {
				t.Errorf("%s.Equals(%s) = %v, want %v", tt.a.Name(), tt.b.Name(), got, tt.want)
			}
		})
	}
}

func TestEqualsIsSymmetric(t *testing.T) {
	all := []Color{Unknown(), Red(), Green(), Blue()}

	for _, a := range all {
		for _, b := range all {
			if a.Equals(b) != b.Equals(a) {
				t.Errorf("Equals is not symmetric for %s and %s", a.Name(), b.Name())
			}
		}
	}
}

func TestNameIsUniquePerValue(t *testing.T) {
	all := []Color{Unknown(), Red(), Green(), Blue()}
	seen := make(map[string]int, len(all))

	for _, c := range all {
		if prev, ok := seen[c.Name()]; ok {
			t.Errorf("duplicate Name() %q for ids %d and %d", c.Name(), prev, c.ID())
		}
		seen[c.Name()] = c.ID()
	}
}
