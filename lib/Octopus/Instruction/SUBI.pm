package Octopus::Instruction::SUBI;
use strict;
use warnings;
use base qw/Octopus::Instruction/;
use Octopus::Util;

sub process {
    my ($self, $vm) = @_;
    my $dreg = $self->mode;
    msg "0x%02X, r%d", $vm->text->[ $vm->pc ], $dreg;

    $vm->pc++;

    $vm->reg->[$dreg] -= $vm->text->[ $vm->pc - 1 ];
    $vm->reg->[$dreg] == 0 ? $vm->flags->zflag(1) : $vm->flags->zflag(0);
}

1;


