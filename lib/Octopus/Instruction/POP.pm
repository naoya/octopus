package Octopus::Instruction::POP;
use strict;
use warnings;
use base qw/Octopus::Instruction/;

use Octopus::Exception;
use Octopus::Util;

sub process {
    my ($self, $vm) = @_;
    my $data = $vm->text->[ $vm->sp++ ];

    if ($self->mode == 0) {
        msg "???\n";
        Octopus::Exception::IllegalMode->throw;
    }

    msg "r%d", $self->mode;
    $vm->reg->[ $self->mode ] = $data;
}

1;

