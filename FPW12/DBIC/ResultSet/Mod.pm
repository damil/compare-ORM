package FPW12::DBIC::ResultSet::Mod;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

sub by_mod_name {
  my ($self, $mod_name) = @_;
  return $self->search({mod_name => $mod_name})->first;
}

1;
