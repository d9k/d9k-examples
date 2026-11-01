package main

import (
	"fmt"
)

func main() {
	acc := &Account{Owner: "Alice", Balance: 100}

	// OK — success
	balance, err := acc.Withdraw(30)
	fmt.Printf("OK:    balance=%v, err=%v\n", balance, err)

	// FAIL — precondition with a custom error
	_, err = acc.Withdraw(1000)
	fmt.Printf("FAIL:  %v\n", err)

	// FAIL — precondition ok=false, err=nil -> default error
	_, err = acc.Withdraw(-5)
	fmt.Printf("FAIL:  %v\n", err)

	// FAIL — frozen account, ok=false, err=nil -> default error
	acc.Frozen = true
	_, err = acc.Withdraw(10)
	fmt.Printf("FAIL:  %v\n", err)

	// OK — unfreeze again
	acc.Frozen = false
	balance, err = acc.Withdraw(20)
	fmt.Printf("OK:    balance=%v, err=%v\n", balance, err)
}
