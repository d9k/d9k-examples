package contract

import (
	"errors"
	"strings"
	"testing"
)

// maxFactorialArg is the largest n whose n! still fits into int64 (20!).
const maxFactorialArg = 20

// factorial computes n! under a contract: 0 <= n <= 20.
// Checks are compact Pre/Post pairs returning (ok, err):
//   - failing check with an error  -> the custom error is reported;
//   - failing check with err=nil   -> ErrDefault is generated.
func factorial(n int) (int64, error) {
	return DoContract(Spec[int64]{
		PreConditions: []PreCheck{
			Pre("input is non-negative", func() (bool, error) {
				if n < 0 {
					return false, errors.New("n must be >= 0")
				}
				return true, nil
			}),
			Pre("input fits int64", func() (bool, error) {
				return n <= maxFactorialArg, nil // ok=false with nil error -> default error
			}),
		},
		Process: func() (int64, error) {
			result := int64(1)
			for i := 2; i <= n; i++ {
				result *= int64(i)
			}
			return result, nil
		},
		PostConditions: []PostCheck[int64]{
			Post("result is positive", func(r int64) (bool, error) {
				return r > 0, nil
			}),
			Post("result divisible by every factor", func(r int64) (bool, error) {
				for i := 2; i <= n; i++ {
					if r%int64(i) != 0 {
						return false, errors.New("not divisible by a factor")
					}
				}
				return true, nil
			}),
		},
	})
}

func TestFactorialSuccess(t *testing.T) {
	tests := []struct {
		n    int
		want int64
	}{
		{0, 1},
		{1, 1},
		{5, 120},
		{20, 2432902008176640000}, // 20!
	}

	for _, tt := range tests {
		got, err := factorial(tt.n)
		if err != nil {
			t.Errorf("factorial(%d): unexpected error %v", tt.n, err)
			continue
		}
		if got != tt.want {
			t.Errorf("factorial(%d) = %d, want %d", tt.n, got, tt.want)
		}
	}
}

func TestFactorialNegativeInputCustomError(t *testing.T) {
	_, err := factorial(-3)
	if err == nil {
		t.Fatal("want error, got nil")
	}
	want := `precondition "input is non-negative": n must be >= 0`
	if !strings.Contains(err.Error(), want) {
		t.Fatalf("got %v, want message to contain %q", err, want)
	}
}

func TestFactorialTooLargeDefaultError(t *testing.T) {
	// ok=false, err=nil -> the library must generate ErrDefault.
	_, err := factorial(21)
	if !errors.Is(err, ErrDefault) {
		t.Fatalf("got %v, want ErrDefault", err)
	}
	if !strings.Contains(err.Error(), `precondition "input fits int64"`) {
		t.Fatalf("got %v, want the failing label in the message", err)
	}
}

func TestNilConditionsAreSafe(t *testing.T) {
	// PreConditions/PostConditions may be nil:
	// range over a nil slice is a no-op, not a panic.
	got, err := DoContract(Spec[string]{
		Process: func() (string, error) { return "hi", nil },
	})
	if err != nil || got != "hi" {
		t.Fatalf("got (%q, %v), want (\"hi\", nil)", got, err)
	}
}

func TestMissingProcess(t *testing.T) {
	_, err := DoContract(Spec[int]{})
	if err == nil || !strings.Contains(err.Error(), "process: missing") {
		t.Fatalf("got %v, want process missing error", err)
	}
}
