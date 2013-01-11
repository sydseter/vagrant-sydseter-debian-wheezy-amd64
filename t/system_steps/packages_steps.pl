#!/usr/bin/perl
# @author Johan Sydseter, <johan.sydseter@startsiden.no>
# @author Thomas Malt, <thomas.malt@startsiden.no>

# Feature steps for verifying the precence of packages

use strict;
use warnings;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;
use Data::Dump;

##
# Scenario: Check the presence of develop packages
##

# Prepare the search for a certain debian package by stashing the module name.
When qr/I search for "(.+)"/, func ($c) {
    $c->stash->{scenario}->{name} = $1;
};

# Confirm the existence of the debian package
Then qr/the output contains "(.+)"/, func ($c) {
    # 
    my $name = $c->stash->{scenario}->{name};
    # 
    ok(has_package($name, $1), "Verify we find package '".$1."' for '". $name
        . "'");
};

# general methods for performing the necessary feature steps

# confirm the existence of a debian package in the apt list with a search 
# string.
sub has_package {
    my ($name, $package) = @_;
    my @found = qx(apt-cache search $name | cut -d" " -f1);
    
    for (@found) {
        chomp;
        return 1 if $_ eq $package;
    }
    return undef;
}
