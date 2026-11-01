// Package contract implements Design by Contract:
// pre-conditions -> process -> post-conditions.
//
// Check functions return (ok, err):
//   - ok == true  -> condition holds;
//   - ok == false -> condition violated. If err != nil it is used as the
//     reason; if err == nil a default error ErrDefault is generated.
package contract

import (
	"errors"
	"fmt"
)

// ErrDefault is the error produced when a check returns ok=false
// without providing its own error.
var ErrDefault = errors.New("contract condition violated")

// PreCheck is a named pre-condition; build it with Pre.
type PreCheck struct {
	Label string
	Fn    func() (bool, error)
}

// Pre builds a pre-condition from a compact pair (label, fn).
func Pre(label string, fn func() (bool, error)) PreCheck {
	return PreCheck{Label: label, Fn: fn}
}

// PostCheck is a named post-condition over the process result; build it with Post.
type PostCheck[T any] struct {
	Label string
	Fn    func(T) (bool, error)
}

// Post builds a post-condition from a compact pair (label, fn).
func Post[T any](label string, fn func(T) (bool, error)) PostCheck[T] {
	return PostCheck[T]{Label: label, Fn: fn}
}

// Spec describes a contract: pre-conditions -> process -> post-conditions.
// T is the result type of Process.
// Slices (not maps) guarantee deterministic evaluation order.
type Spec[T any] struct {
	PreConditions  []PreCheck
	Process        func() (T, error)
	PostConditions []PostCheck[T]
}

// DoContract runs the contract.
// It returns (zero, err) if any stage fails.
func DoContract[T any](s Spec[T]) (T, error) {
	var zero T

	// 1. Pre-conditions — check the input.
	for _, c := range s.PreConditions {
		ok, err := c.Fn()
		if !ok {
			return zero, wrapErr("precondition", c.Label, err)
		}
	}

	// 2. Process.
	if s.Process == nil {
		return zero, errors.New("process: missing")
	}
	result, err := s.Process()
	if err != nil {
		return zero, fmt.Errorf("process: %w", err)
	}

	// 3. Post-conditions — check the output.
	for _, c := range s.PostConditions {
		ok, cerr := c.Fn(result)
		if !ok {
			return zero, wrapErr("postcondition", c.Label, cerr)
		}
	}

	return result, nil
}

// wrapErr wraps a check failure; when the check provided no error,
// the default error is used.
func wrapErr(phase, label string, err error) error {
	if err == nil {
		err = ErrDefault
	}
	return fmt.Errorf("%s %q: %w", phase, label, err)
}
