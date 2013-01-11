#!/usr/bin/perl
use warnings;
use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;
=head1 AUTHOR

Johan Sydseter, <johan.sydseter@startsiden.no>

=head1 DESCRIPTION

An example that explains how you can write BDD tests in perl

=head2 Feature

This is an example of a feature

=head3 Scenario

Here is the description of a scenario

=cut

=head4 When the first operand is "<operand_one>"

Uses numeric values from the first column in the calc_example.feature
file as the first operand in the statement.

=cut
When qr/the first operand is "(.+)"/, func ($c) {
    my $variable = $1;

    $c->stash->{scenario}->{first_operand} = $variable; 
};

=head4 And the second operand is "<operand_two>"

Uses numeric values from the second column in the calc_example.feature
file as the second operand in the statement.

=cut
When qr/the second operand is "(.+)"/, func ($c) {
    my $variable = $1;

    $c->stash->{scenario}->{second_operand} = $variable; 
};

=head4 And the operator "<operator>" is beeing used

A certain operator for doing the calculation

=cut
When qr/the operator "(.+)" is beeing used/, func ($c) {
    my $operator = $1;

    $c->stash->{scenario}->{operator} = $operator;

};


=head4 Then the total should be "<sum>"

The sum of the whole statement

=cut
Then qr/the total should be "(.+)"/, func ($c) {

    my $expected_sum = $1;
    my $first_operand = $c->stash->{scenario}->{first_operand};
    my $second_operand = $c->stash->{scenario}->{second_operand};
    my $operator = $c->stash->{scenario}->{operator};

    %operations = (
        "+" => ${first_operand} + ${second_operand},
        "/" => ${first_operand} / ${second_operand},
        "-" => ${first_operand} - ${second_operand},
        "*" => ${first_operand} * ${second_operand}
    );

    my $sum = $operations{$operator};

    ok($expected_sum == $sum, "the statement ${first_operand} ${operator} ${second_operand} is equal to ${expected_sum}");

};

