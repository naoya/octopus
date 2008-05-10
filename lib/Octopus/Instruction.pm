package Octopus::Instruction;
use strict;
use warnings;
use base qw/Class::Accessor::Lvalue::Fast/;
use UNIVERSAL::require;

__PACKAGE__->mk_accessors(qw/name mode/);

my @Inst;

BEGIN {
    $Inst[0]  = 'NOP';
    $Inst[1]  = 'MOV';
    $Inst[2]  = 'IN';
    $Inst[3]  = 'OUT';
    $Inst[4]  = 'MOVI';
    $Inst[5]  = 'ADDI';
    $Inst[6]  = 'SUBI';
    $Inst[7]  = 'ANDI';
    $Inst[8]  = 'ORI';
    $Inst[9]  = 'MULI';
    $Inst[10] = 'DIVI';
    $Inst[11] = 'TESTI';
    $Inst[12] = 'JMP';
    $Inst[13] = 'JZ';
    $Inst[14] = 'JNZ';
    $Inst[15] = 'JSR';
    $Inst[16] = 'PUSH';
    $Inst[17] = 'POP';
    $Inst[18] = 'CALL';
    $Inst[19] = 'RET';
    $Inst[31] = 'HLT';

    for (@Inst) {
        defined $_ or next;
        my $module = join '::', __PACKAGE__, $_;
        $module->require or die $@;
    }
}

sub process { Octopus::Exception::NotImplemented->throw }

sub retrieve {
    my ($class, $opecode) = @_;
    return $class->_get_instruction($opecode);
}

{
    my %Cache;
    sub _get_instruction {
        my ($class, $opecode) = @_;
        my $name = $Inst[$opecode] or return;
        $Cache{$name} and return $Cache{$name};

        my $module = join '::', __PACKAGE__, $name;
        my $inst;
        eval {
            $inst = $module->new;
        };
        return if $@;

        $inst->name = lc $name;
        $Cache{$name} = $inst;
        return $inst;
    }
}

1;
