#!/usr/bin/perl
# @author Johan Sydseter, <johan.sydseter@startsiden.no>
# Feature steps for verifying that the right locale types is setup on the 
# system.

use strict;
use warnings;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;
use Data::Dump;

##
# Scenario: Check that the system locales contains the right configuration
##

# given that a locale option exist
When qr/the locale "(.+)"/, func ($c) {
    my $locale_type = $1;    
    ok(locale_type_exist($locale_type), "Verify that the $locale_type exist.");
    $c->stash->{scenario}->{locale}->{type} = $locale_type;
};

# then this is the value
Then qr/this is the "(.+)"/, func ($c) {
    my $type = $c->stash->{scenario}->{locale}->{type};
    my $value = get_locale_value($type);
    my $expected_value = $1;

    ok($expected_value eq $value, 
        "Verify that the $type has the value: $expected_value the following "
        . "locale was found: [$value]");
};

# return 1 if the locale type exist
sub locale_type_exist {
    my ($locale_type) = @_;
    my $found = qx (locale | grep $locale_type= | cut -d"=" -f1);

    chomp $found;

    return 1 if $found;

    return undef;
}

# retrieve the value for the locale type from the environment
sub get_locale_value {
    my ($locale_type) = @_;
    my $value = qx (locale | grep $locale_type= | cut -d"=" -f2 | tr -d "\\"" );
    chomp $value;
    return $value if $value;

    return "";
}
