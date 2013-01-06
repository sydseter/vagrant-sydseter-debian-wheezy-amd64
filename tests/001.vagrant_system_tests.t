#!/usr/bin/perl
# author Johan Sydseter, <johan.sydseter@startsiden.no>
# author Thomas Malt, <malt@startsiden.no>
# System tests to verify the state of the novus base server
use strict;
use warnings;

use FindBin::libs;
use File::Basename;
use Test::More;
use Test::BDD::Cucumber::Loader;
use Test::BDD::Cucumber::Harness::TestBuilder;


subtest 'System tests for vagrant' => sub {

    my $features_path = dirname($0) . '/features';

    my ( $executor, @features ) = Test::BDD::Cucumber::Loader->load(
        $features_path
    );

    my $harness = Test::BDD::Cucumber::Harness::TestBuilder->new({});

    $executor->execute( $_ ,$harness ) for @features;

};
done_testing;
