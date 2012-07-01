use strict;
use warnings;
use 5.010;

use lib "..";
use FPW12::DBIC;

my $schema = FPW12::DBIC->connect("dbi:SQLite:dbname=../cpandb.sql");

my $rs_dami = $schema->resultset('Auth')->search({cpanid => 'DAMI'});
my $dami    = $rs_dami->first;

my @dists = $rs_dami->search_related(
  'dists', 
  {},
  {prefetch => {depends => 'mod'}},
 );

my @jdists = $rs_dami->search_related(
  'dists', 
  {},
  {join => {depends => 'mod'}},
 );


foreach my $dist (@dists) {
  say $dist->dist_name;
  my @depends = $dist->prereq_mods;
  say "  ", $_->mod_name foreach @depends;
}

