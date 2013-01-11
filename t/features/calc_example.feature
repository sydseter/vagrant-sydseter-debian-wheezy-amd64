#
# @author Johan Sydseter, <johan.sydseter@startsiden.no>
#
Feature: This is an example of a feature
    This is to show how you can create system tests to test
    the state of your vagrant box.

    There are a number of common steps that you can use for
    testing. You may create symbolic links and place them in
    the feature_steps folder. Please read the documentation
    for test-bdd-cucumber-perl on the web for more info.

    Scenario: An simple calculator example
        When the first operand is "<operand_one>"
        And the operator "<operator>" is beeing used
        And the second operand is "<operand_two>"
        Then the total should be "<sum>"
        Examples:
            | operand_one | operator | operand_two | sum |
            | 2           | +        | 2           | 4   |
