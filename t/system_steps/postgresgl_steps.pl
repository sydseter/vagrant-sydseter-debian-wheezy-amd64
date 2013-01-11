#!/usr/bin/perl
# author: Johan Sydseter, <johan.sydseter@startsiden.no>
# Feature steps for verifying that the postgresql server is set up
# correctly.

use strict;
use warnings;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;
use Data::Dump;

##
# Scenario: Check that th right locals are installed and configured
##

# when the cluster schema exists
When qr/the schema "(.+)"/, func ($c) {
    my $schema = $1;
    
    ok(schema_exists($schema), "check for the existence of $schema");

    $c->stash->{scenario}->{schema} = $1;
};

# then this is the collation it has
Then qr/the schema has the collation "(.+)"/, func ($c) {
    my $collation = $1;

    my $schema = $c->stash->{scenario}->{schema};

    ok(has_collation($schema, $collation), 
        "check $schema for the collation $collation");
};

# then this is the ctype it is set with
Then qr/the schema has the ctype "(.+)"/, func ($c) {
    my $ctype = $1;

    my $schema = $c->stash->{scenario}->{schema};

    ok(has_ctype($schema, $ctype), 
        "check $schema for the ctype $ctype");
    
};

# then this is the char encoding that it uses
Then qr/the schema has the encoding "(.+)"/, func ($c) {
    my $encoding = $1;

    my $schema = $c->stash->{scenario}->{schema};

    ok(has_encoding($schema, $encoding), 
        "check $schema for the encoding $encoding");
    
};

# return 1 if the schema exist and undef otherwise.
# param schema - the postgresql schema to check against.
sub schema_exists {
    my ($schema) = @_;
    
    my $schema_found = qx(psql -U postgres -c "\\l" | head -n -2 | sed -n '4,10000p' | tr -d ' ' | grep ^$schema | cut -d'|' -f1);

    chomp $schema_found;

    return 1 if ($schema eq $schema_found);

    return undef;
}

# return 1 if the schema has the ctype specified and undef otherwise
# param schema - the postgresql schema to check against.
# param ctype  - the ctype that you check for
sub has_ctype {
    my ($schema, $ctype) = @_;

    my $ctype_found = qx(psql -U postgres -c "\\l" | head -n -2 | sed -n '4,10000p' | tr -d ' ' | grep ^$schema | cut -d'|' -f5);

    chomp $ctype_found;

    return 1 if ($ctype eq $ctype_found);

    return undef;
}

# return 1 if the schema has the collaton specified and undef otherwise
# param schema    - the postgresql schema to check against.
# param collation - the collation that you want to check for
sub has_collation {
    my ($schema, $collation) = @_;
    
    my $collation_found = qx(psql -U postgres -c "\\l" | head -n -2 | sed -n '4,10000p' | tr -d ' ' | grep ^$schema | cut -d'|' -f4);

    chomp $collation_found;

    return 1 if ($collation eq $collation_found);

    return undef;
}

# return 1 if the schema has the encoding specified and undef otherwise
# param schema   - the postgresql schema to check against.
# param encoding - the encoding you want to check for
sub has_encoding {
    my ($schema, $encoding) = @_;
    my $encoding_found = qx(psql -U postgres -c "\\l" | head -n -2 | sed -n '4,10000p' | tr -d ' ' | grep ^$schema | cut -d'|' -f3);

    chomp $encoding_found;

    return 1 if ($encoding eq $encoding_found);

    return undef;
}
