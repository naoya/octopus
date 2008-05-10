package Octopus;
use strict;
use warnings;
use base qw/Class::Accessor::Lvalue::Fast/;

our $VERSION = 0.01;

use Octopus::Instruction;
use Octopus::Exception;
use Octopus::Memory;
use Octopus::Register;
use Octopus::Flag;
use Octopus::Util;

__PACKAGE__->mk_accessors(qw/text port reg flags step nop_wait max_exec_steps fmt_text_bytes/);

sub new {
    my $class = shift;
    my $self = $class->SUPER::new(@_);
    $self->_init(@_);
    bless $self, $class;
}

sub _init {
    my $self = shift;

    $self->text           = Octopus::Memory->new(256);       # Code and data area
    $self->port           = Octopus::Memory->new(256, 0xFF); # I/O port area
    $self->reg            = Octopus::Register->new;          # General purpose registers
    $self->flags          = Octopus::Flag->new;              # Flag bits
    $self->pc             = 0;                               # Program counter
    $self->step           = 0;                               # How many steps were executed?
    $self->nop_wait       = 200_000;                         # Wait for NOP (200 msec)
    $self->max_exec_steps = 200;                             # Limit execution steps
}

sub pc : lvalue {
    shift->reg->[7];
}

sub rad : lvalue {
    shift->reg->[6];            # Return address holder
}

sub sp : lvalue {
    shift->reg->[5];            # Stack pointer
}

sub store {
    my ($self, @bytes) = @_;
    my $i = 0;
    $self->text->[$i++] = $_ for @bytes;
    $self->text->[$i] = 0xf8;   # Termintate with "hlt" instruction
}

sub show_steps {
    msg "    Step = %d\n", shift->step;
}

sub execute {
    my $self = shift;
    my $cur = $self->text->[$self->pc];
    defined $cur or Octopus::Exception::OverRun->throw;

    $self->pc++;

    my $opecode = ($cur & 0xf8) >> 3;
    my $inst = Octopus::Instruction->retrieve($opecode)
        or Octopus::Exception::IllegalCode->throw;

    msg "%02X: %s ", $self->pc - 1, $inst->name;

    $inst->mode = ($cur & 7);
    my $ret = $inst->process($self);

    msg "\n";

    $self->step++;
    if ($self->max_exec_steps and $self->step >= $self->max_exec_steps) {
        Octopus::Exception::MaxExecSteps->throw;
    }

    return $ret;
}

1;
