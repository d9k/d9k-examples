package main

import (
	. "contracts/contract"
	"errors"
	"fmt"
)

// Account is a simple bank account.
type Account struct {
	Owner   string
	Balance float64
	Frozen  bool
}

// Withdraw runs a contract: pre-conditions -> process -> post-conditions.
// Checks are compact Pre/Post pairs returning (ok, err);
// when ok=false and err=nil the library generates a default error.
func (a *Account) Withdraw(amount float64) (float64, error) {
	originalBalance := a.Balance // remember for the post-condition

	return DoContract(Spec[float64]{
		PreConditions: PreChecks{
			Pre("amount is positive", func() (bool, error) {
				if amount <= 0 {
					return false, fmt.Errorf("amount must be > 0, got %v", amount)
				}
				return true, nil
			}),
			Pre("account not frozen", func() (bool, error) {
				return !a.Frozen, nil // ok=false with nil error -> default error
			}),
			Pre("sufficient funds", func() (bool, error) {
				if a.Balance < amount {
					return false, fmt.Errorf("insufficient: balance=%v, amount=%v", a.Balance, amount)
				}
				return true, nil
			}),
		},
		Process: func() (float64, error) {
			if a.Balance-amount < 0 {
				return 0, errors.New("withdraw would go negative")
			}
			a.Balance -= amount // mutate state
			return a.Balance, nil
		},
		PostConditions: PostChecks[float64]{
			Post("balance is non-negative", func(b float64) (bool, error) {
				return b >= 0, nil // ok=false with nil error -> default error
			}),
			Post("balance decreased by amount", func(b float64) (bool, error) {
				expected := originalBalance - amount
				if b != expected {
					return false, fmt.Errorf("expected %v, got %v", expected, b)
				}
				return true, nil
			}),
		},
	})
}
