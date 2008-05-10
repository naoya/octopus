package Octopus::Register;
use strict;
use warnings;
use Octopus::Util;

sub new {
    my $self = bless [], shift;
    $self->[$_] = 0 for 0..15;
    $self;
}

sub dump {
    my $self = shift;

    msg "Register = ";
    for (my $i = 0; $i < 16; $i++) {
        msg "%02X ", $self->[$i];
    }
    msg "\n";
}

1;
