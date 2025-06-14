Feature: Greeting

	Scenario: Say hello
		When the greeter says hello
		Then I should have heard "hello"

	Scenario: Say Good Bye
		When the greeter says goodbye
		Then I should have heard "goodbye"