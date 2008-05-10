#!/usr/local/bin/perl
use strict;
use warnings;
use FindBin::libs;

use Octopus;
use Octopus::Util;

my %argv;
use App::Options (
    values => \%argv,
    option => {
        wait  => "type=integer; default=200000",
        steps => "type=integer; default=200",
        text  => "type=integer; default=32",
    }
);

my $vm = Octopus->new;
$vm->nop_wait       = $argv{wait};
$vm->max_exec_steps = $argv{steps};
$vm->store(@ARGV);
$vm->text->dump;

print_line();

eval {
    $vm->execute while (1);
};

if (my $e = Exception::Class->caught) {
    $e->can('description') ? msg "\n## %s \n", $e->description : die "\n", $@;
}

print_line();
print_measure();

$vm->text->dump($argv{text});
$vm->port->dump(32, "    Port = ");
$vm->reg->dump;
$vm->flags->dump;
$vm->show_steps;
