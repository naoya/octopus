package Octopus::Instruction::HLT;
use strict;
use warnings;
use base qw/Octopus::Instruction/;

sub process {
    Octopus::Exception::Halt->throw();
}

1;

