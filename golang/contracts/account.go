package main

import (
	"errors"
	"fmt"

	"contracts/contract"
)

// Account is a simple bank account.
type Account struct {
	Owner   string
	Balance float64
	Frozen  bool
}

// Withdraw runs a contract: pre-conditions -> process -> post-conditions.
// Each check returns (ok, err); when ok=false and err=nil the library
// generates a default error.
func (a *Account) Withdraw(amount float64) (float64, error) {
	originalBalance := a.Balance // remember for the post-condition

	return contract.DoContract(contract.Spec[float64]{
		PreConditions: []contract.PreCheck{
			{
				Label: "amount is positive",
				Fn: func() (bool, error) {
					if amount <= 0 {
						// custom error message
						return false, fmt.Errorf("amount must be > 0, got %v", amount)
					}
					return true, nil
				},
			},
			{
				Label: "account not frozen",
				Fn: func() (bool, error) {
					// ok=false with nil error -> default error is generated
					return !a.Frozen, nil
				},
			},
			{
				Label: "sufficient funds",
				Fn: func() (bool, error) {
					if a.Balance < amount {
						return false, fmt.Errorf("insufficient: balance=%v, amount=%v",
							a.Balance, amount)
					}
					return true, nil
				},
			},
		},
		Process: func() (float64, error) {
			if a.Balance-amount < 0 {
				return 0, errors.New("withdraw would go negative")
			}
			a.Balance -= amount // mutate state
			return a.Balance, nil
		},
		PostConditions: []contract.PostCheck[float64]{
			{
				Label: "balance is non-negative",
				Fn: func(newBalance float64) (bool, error) {
					// ok=false with nil error -> default error is generated
					return newBalance >= 0, nil
				},
			},
			{
				Label: "balance decreased by amount",
				Fn: func(newBalance float64) (bool, error) {
					expected := originalBalance - amount
					if newBalance != expected {
						return false, fmt.Errorf("expected %v, got %v", expected, newBalance)
					}
					return true, nil
				},
			},
		},
	})
}
