package Octopus::Instruction::NOP;
use strict;
use warnings;
use base qw/Octopus::Instruction/;
use Time::HiRes qw/usleep/;

sub process {
    my ($self, $vm) = @_;
    usleep($vm->nop_wait);            # Wait in NOP operation
    0;
}

1;

