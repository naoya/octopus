package Octopus::Instruction::OUT;
use strict;
use warnings;
use base qw/Octopus::Instruction/;
use Octopus::Util;

sub process {
    my ($self, $vm) = @_;

    my $nport = $vm->text->[ $vm->pc++ ];  # Read port number in operand
    $vm->port->[ $nport ] = $vm->reg->[0]; # Update port data with R0

    msg "r0, [ %d ]", $nport;

    ## TODO
    # octopus.c �ǤϤ����� $nport ���ͤˤ�ä� sound() �� led() ���ƤФ��.
    # OUT �� I/O �ݡ��Ȥ��ͤ��Ѳ����뤿�Ӥˤ����ͤ˹�碌�ƥǥХ��������.
    # int oct_out(int mod) �򻲾�
    #
    #define PORT_SOUND	0	// Sound control
    #define PORT_FREQ_HIGH	1	// Timer count (higher byte)
    #define PORT_FREQ_LOW	2	// Timer count (lower byte)
    #define PORT_KEY_LED	3	// Keyboard LED control
}

1;
