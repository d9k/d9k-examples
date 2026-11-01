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

// Helper function types: they name the contract concepts so that the
// declarations below (and any user code) stay short and self-documenting.
type (
	// PreFn is a pre-condition check: it inspects the input / outer state.
	PreFn func() (bool, error)

	// ProcessFn is the process step of a contract; T is its result type.
	ProcessFn[T any] func() (T, error)

	// PostFn is a post-condition check over the process result.
	PostFn[T any] func(T) (bool, error)
)

// PreCheck is a named pre-condition; build it with Pre.
type PreCheck struct {
	Label string
	Fn    PreFn
}

// Pre builds a pre-condition from a compact pair (label, fn).
func Pre(label string, fn PreFn) PreCheck {
	return PreCheck{Label: label, Fn: fn}
}

// PostCheck is a named post-condition over the process result; build it with Post.
type PostCheck[T any] struct {
	Label string
	Fn    PostFn[T]
}

// Post builds a post-condition from a compact pair (label, fn).
func Post[T any](label string, fn PostFn[T]) PostCheck[T] {
	return PostCheck[T]{Label: label, Fn: fn}
}

// PreChecks is an ordered list of pre-conditions; slices keep the
// evaluation order deterministic (unlike a map).
type PreChecks []PreCheck

// PostChecks is an ordered list of post-conditions over a result of type T.
type PostChecks[T any] []PostCheck[T]

// Spec describes a contract: pre-conditions -> process -> post-conditions.
type Spec[T any] struct {
	PreConditions  PreChecks
	Process        ProcessFn[T]
	PostConditions PostChecks[T]
}

// DoContract runs the contract.
// It returns (zero, err) if any stage fails.
func DoContract[T any](s Spec[T]) (T, error) {
	var zero T

	// 1. Pre-conditions — check the input. A nil PreConditions is a no-op.
	for _, c := range s.PreConditions {
		ok, err := c.Fn()
		if !ok {
			return zero, wrapErr("precondition", c.Label, err)
		}
	}

	// 2. Process. A nil Process would panic when called; report it instead.
	if s.Process == nil {
		return zero, errors.New("process: missing")
	}
	result, err := s.Process()
	if err != nil {
		return zero, fmt.Errorf("process: %w", err)
	}

	// 3. Post-conditions — check the output. A nil PostConditions is a no-op.
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
