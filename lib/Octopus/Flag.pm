package Octopus::Flag;
use strict;
use warnings;
use Octopus::Util;

use constant ZFLAG => 1;

sub new {
    my $class = shift;
    my $flag = 0;
    bless \$flag, $class;
}

sub zflag {
    my ($self, $bool) = @_;
    if (defined $bool) {
        $bool ? ($$self |= ZFLAG) : ($$self &= ~ZFLAG);
    } else {
        $$self & ZFLAG;
    }
}

sub dump {
    my $self = shift;
    msg "    Flag = ";
    msg $self->zflag ? 'Z' : 'NZ';
    msg "\n";
}

1;
