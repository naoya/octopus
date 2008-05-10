package Octopus::Instruction::JZ;
use strict;
use warnings;
use base qw/Octopus::Instruction/;
use Octopus::Util;

sub process {
    my ($self, $vm) = @_;
    my $dst;
    if ($self->mode == 0) {
        $dst = $vm->text->[ $vm->pc ];
        msg "0x%02X", $dst;
    } else {
        $dst = $vm->reg->[ $self->mode ];
        msg "r%d", $self->mode;
    }

    $vm->pc = $dst if $vm->flags->zflag;
}

1;

