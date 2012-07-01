use strict;
use warnings;
use 5.010;

use lib "..";
use FPW12::DBIC;

my $datasource = "dbi:SQLite:dbname=../cpandb.sql";
my $schema = FPW12::DBIC->connect($datasource);


my @dists = $schema->resultset('Dist')->search(
  {dist_name => {-like => 'DBIx%'}},
  {columns => [qw/dist_name dist_vers/]},
);

foreach my $dist (@dists) {
  printf "%s (%s)\n", $dist->dist_name, $dist->dist_vers;
}

