
# @author Johan Sydseter, <johan.sydseter@startsiden.no>
#
Feature: Verify the list of debian packages installed on the system

    Scenario: Check that the right debian packages are installed
        When "<package>" is installed on the system
        Then it has this version number "<version>"
        Examples:
            | package                        | version         |
            | libtest-bdd-cucumber-perl      | 0.11-1          |
            | sudo                           | 1.8.5p2-1       |
            | linux-headers-3.2.0-4-amd64    | 3.2.35-2        |
            | build-essential                | 11.5            |
            | virtualbox-guest-utils         | 4.1.18-dfsg-1.1 |
            | ssh                            | 1:6.0p1-3       |
