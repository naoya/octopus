package Octopus::Util;
use strict;
use warnings;
use Exporter::Lite;

our @EXPORT    = qw/msg print_line print_measure/;
our @EXPORT_OK = @EXPORT;

sub msg (@) {
    printf STDERR @_;
}

sub print_measure {
    msg "            0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15\n";

}

sub print_line {
    msg "----------------------------------------------------------\n";
}

1;
