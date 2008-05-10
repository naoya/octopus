package Octopus::Instruction::RET;
use strict;
use warnings;
use base qw/Octopus::Instruction/;

use Octopus::Exception;
use Octopus::Util;

sub process {
    my ($self, $vm) = @_;
    if ($self->mode) {
        msg "???\n";
        Octopus::Exception::IllegalMode->throw;
    }

    $vm->pc = $vm->text->[ $vm->sp++ ];
}

1;

