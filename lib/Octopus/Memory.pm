package Octopus::Memory;
use strict;
use warnings;

use Octopus::Util;

sub new {
    my ($class, @args) = @_;
    my $self = bless [], $class;

    my $max = $args[0] || 256;
    my $ini = $args[1] || 0;

    for (my $i = 0; $i < $max; $i++) {
        $self->[$i] = $ini
    }
    $self;
}

sub dump {
    my ($self, $fmt_bytes, $label) = @_;
    $fmt_bytes ||= 32;

    msg $label || "  Memory = ";
    for (my $i = 0; $i < $fmt_bytes; $i++) {
        msg "           " if $i && $i % 16 == 0;
        msg "%02X ", $self->[$i];
        msg "\n" if $i % 16 == 15;
    }
}

1;
