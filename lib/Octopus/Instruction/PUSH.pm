package Octopus::Instruction::PUSH;
use strict;
use warnings;
use base qw/Octopus::Instruction/;
use Octopus::Util;

sub process {
    my ($self, $vm) = @_;
    my $data;

    if ($self->mode == 0) {
        $data = $vm->text->[ $vm->pc++ ];
        msg "0x%02X", $data;
    } else {
        $data = $vm->reg->[ $self->mode ];
        msg "r%d", $self->mode;
    }

    $vm->text->[ --$vm->sp ] = $data;
}

1;
