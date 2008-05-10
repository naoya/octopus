package Octopus::Instruction::IN;
use strict;
use warnings;
use base qw/Octopus::Instruction/;
use Octopus::Util;

sub process {
    my ($self, $vm) = @_;

    my $nport = $self->text->[ $vm->pc++ ];    # Read port number in operand
    $self->reg->[0] = $self->port->[ $nport ]; # Transfer port data to R0

    msg "[ 0x%02X ], r0", $nport;
}

1;
