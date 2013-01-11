#!/usr/bin/perl
use warnings;
use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;
=head1 AUTHOR 

Johan Sydseter, <johan.sydseter@startsiden.no>

=head1 DESCRIPTION

These common steps tests the following features.

=cut

=head2 Feature

Verifying the installability of custom built php packages

and verifying the state of system dependencies

=head3 Scenario

Verify that a custom built php package can be installed

=cut

=head4 When the "<path>" exist

=cut
When qr/the "(.+)" exist/, func ($c) {
    my $dir = $1;
    my $status = 0;


    if(-d $dir) {
        $status = 1;
    }

    $c->stash->{scenario}->{installable} = $status;

    ok($status, "Whether ${dir} exist.");
};


=head4 And the PHP API Version is "<api_version>"

=cut
When qr/the PHP API Version is "(.+)"/, func ($c) {
  my $api_versions = $1;
  my @php_api_versions = split(/,/, $api_versions);

  my $version = qx(phpize5 --version | head -n 2 | tail -n -1 | tr -d ' ' | cut -d':' -f2);
  chomp($version);

  my $is_match;
  foreach (@php_api_versions) {
      $is_match = ( $_ =~ m/$version/ ) || 0;
  }

  ok($is_match, "The PHP API Version has to be ${api_versions} but was ${version}.");

};

=head4 Then the "<package>" should be installable

=cut

Then qr/the "(.+)" should be installable/, func ($c) {

    my $package = $1;
    my $is_installable = $c->stash->{scenario}->{installable};

    ok($is_installable, "${package} can not be installed");
};




=head3 Scenario

Verify the state of php modules

=cut

=head4 When "<package>" is installed with one of these php api "<keys>"

=cut
When qr/ "(.+)" is installed with one of these php api "(.+)"/, func ($c) {
    my $package = $1;
    my $api_keys = $2;

    my @php_api_versions = split(/,/, $api_keys);

    my $version = qx(phpize5 --version | head -n 2 | tail -n -1 | tr -d ' ' | cut -d':' -f2);

    chomp($version);

    my $is_match;
    foreach (@php_api_versions) {
        $is_match = ( $_ =~ m/$version/ ) || 0;
    }

    ok($is_match, "The PHP API Version has to be ${api_versions} but was ${version}.");

};

=head4 And the php support for "<module>" is "<status>"

=cut
When qr/the php support "(.+)" is "(.+)"/, func ($c) {
    my $module = $1;
    my $status = $2;

};

=head4 Then the "<class>" can be instantiated

=cut
Then qr/the "(.+)" can be instantiated/, func ($c) {

    $class = $1;
    $is_installed = qx(php -r '$config=array("application" => array("directory" => dirname("./"),"dispatcher" => array("catchException" => 1),"view" => array("ext" => "phtml"))); $app = new '${class}'($config);');
};

1;

