use strict;
use warnings;
use 5.010;

use lib "..";
use FPW12::DBIC;

my $schema = FPW12::DBIC->connect("dbi:SQLite:dbname=../cpandb.sql");

my $rs   = $schema->resultset('Auth')->search({cpanid => 'DAMI'});
my $dami = $rs->first;

say $dami->fullname;

my @dists = $dami->dists(undef,
  {prefetch => {depends =>  'mod'}}
 );

foreach my $dist (@dists) {
  say $dist->dist_name;
  foreach my $dep ($dist->depends) {
    say "  ", $dep->mod->mod_name;
  }
}

