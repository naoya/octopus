package Octopus::Exception;
use strict;
use warnings;

use Exception::Class
    (
        'Octopus::Exception::OverRun'        => { description => 'Segment over-run' },
        'Octopus::Exception::IllegalCode'    => { description => 'Illegal operation code' },
        'Octopus::Exception::IllegalMode'    => { description => 'Illegal operation mode' },
        'Octopus::Exception::Halt'           => { description => 'System is halted' },
        'Octopus::Exception::MaxExecSteps'   => { description => 'Too many steps' },

        'Octopus::Exception::NotImplemented' => { description => 'Method not implemented yet' },
    );

1;
