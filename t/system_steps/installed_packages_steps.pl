#!/usr/bin/perl
use strict;
use warnings;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

=head1 AUTHORS

Johan Sydseter, C<< <johan.sydseter@startsiden.no> >>
Thomas Malt, C<< <thomas.malt@startsiden.no> >>

=cut

=head1 DESCRIPTION

These steps tests debian packages

=cut

=head3 Scenario: Check that the right debian packages are installed

=cut

=head4 When "<package>" is installed on the system

=cut
When qr/"(.+)" is installed on the system/, func ($c) {
    my $package = $1;
    ok(has_installed_package($package), "Verify that the '". $package . "' is installed");
    $c->stash->{scenario}->{package} = $package;
};

=head4 Then it has this version number "<version>"

=cut
Then qr/it has this version number "(.+)"/, func ($c) {
    my $version = $1;
    my $package = $c->stash->{scenario}->{package};
    ok(package_has_version($package,$version));
};

# Verify that all necessary modules is made available to the perl environment
Then qr/this perl "(.+)"/, func ($c) {
    use_ok($1);
};

##
# Scenario: Check that novus files and directories exists in their right 
# locations across the system
##
Given qr/this novus "(.+)"/, func ($c) {
    $c->stash->{scenario}->{filename} = $1;
};

# Verify that all necessary scripts are present on the system
Then qr/this can be found in this system "(.+)"/, func ($c) {
    my $directory = $1;
    my $filename  = $c->stash->{scenario}->{filename};

    ok(-d $directory, "Verify the directory |$directory| exist first");
    ok(-f "$directory/$filename", "Verify the file |$filename| exists");
};

# confirm that a certain package is installed.
sub has_installed_package {
    my ($package) = @_;

    my $print_arg = '$2';
    my $status = qx(dpkg --get-selections $package | awk '{print $print_arg}');
    chomp $status;

    return 1 if $status eq 'install';

    return undef;
}

sub package_has_version {
  my ($package,$version) = @_;

  my $actual_version = qx(dpkg -l ${package} | tail -n 1);

  ok(1,"The actual version: ${actual_version}");

  chomp $actual_version;

  if ( $actual_version =~ m/$version/) {
      return 1;
  }

  return 0;
}
