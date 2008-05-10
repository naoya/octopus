package Octopus::Instruction::MOV;
use strict;
use warnings;
use base qw/Octopus::Instruction/;
use Octopus::Util;

my @AddressingModes = (
    \&IMM,                       # Immediate value (unusable)
    \&REG,                       # Register  (unusable)
    \&IMMREG,                    # Immediate / Register
    \&REGREG,                    # Register / Register
    \&REGMEM,                    # Register / Memory
    \&MEMREG,                    # Memory / Register
    \&INDREG,                    # Indirect / Register
    \&REGIND,                    # Register / Indirect
);

sub process {
    my ($self, $vm) = @_;
    my $st = $AddressingModes[$self->mode]->($vm);
    return $st < 0 ? $st : 0;
}

sub IMMREG {
    my $vm = shift;

    msg "0x%02X, r0", $vm->text->[$vm->pc];

    $vm->reg->[0] = $vm->text->[$vm->pc];
    $vm->pc++;
}

sub REGREG {
    my $vm = shift;
    my $src = ($vm->text->[$vm->pc] & 0xf0) >> 4;
    my $dst = $vm->text->[$vm->pc] & 0x0f;

    msg "r%d, r%d", $src, $dst;

    $vm->reg->[$dst] = $vm->reg->[$src];
    $vm->pc++;
}

sub REGMEM {
    my $vm = shift;

    msg "r0, [ 0x%02X ]", $vm->text->[$vm->pc];

    $vm->text->[ $vm->text->[$vm->pc] ] = $vm->reg->[0];
    $vm->pc++;
}

sub MEMREG {
    my $vm = shift;

    msg "[ 0x%02X ], r0", $vm->text->[$vm->pc];

    $vm->reg->[0] = $vm->text->[ $vm->text->[$vm->pc] ];
    $vm->pc++;
}

sub INDREG {
    my $vm = shift;

    my $src = ($vm->text->[$vm->pc] & 0xf0) >> 4;
    my $dst = $vm->text->[$vm->pc] & 0x0f;

    msg "r%d, [ r%d ]", $src, $dst;

    $vm->reg->[$dst] = $vm->text->[ $vm->reg->[$src] ];
    $vm->pc++;
}

sub REGIND {
    my $vm = shift;

    my $src = ($vm->text->[$vm->pc] & 0xf0) >> 4;
    my $dst = $vm->text->[$vm->pc] & 0x0f;

    msg "r%d, [ r%d ]", $src, $dst;

    $vm->text->[ $vm->reg->[$dst] ] = $vm->reg->[$src];
    $vm->pc++;
}

1;
