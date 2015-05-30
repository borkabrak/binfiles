#!/usr/bin/env perl
use 5.012;
use strict;
use Creature;

my $mob = Creature->new(
    name => "slime",
    description => "gelatinous and quivering",
    hp => 5);

say "You see a " . $mob->name . "!  "
    . "It appears " . $mob->description . ".  "
    . "\n";

say "Because of your neo-like powers to SEE THE CODE, you can tell that it has "
    . $mob->hp . " hitpoints.  \n";
