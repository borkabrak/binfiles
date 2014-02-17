package Creature;
use Moose;

has name => (
    is => 'rw',
    isa => 'Str',
);

has hp => (
    is => 'rw',
    isa => 'Int',
    handles => [qw( life hitpoints )],
);

has description => (
    is => 'rw',
    isa => 'Str'
);

no Moose;
__PACKAGE__->meta->make_immutable;
