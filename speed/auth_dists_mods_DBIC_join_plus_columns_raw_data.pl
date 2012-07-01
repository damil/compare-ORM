use strict;
use warnings;
use 5.010;

use lib "..";
use FPW12::DBIC;
no warnings 'uninitialized';
$\ = "\n";
$, = "\t";
use Time::HiRes qw/time/;

my $datasource = "dbi:SQLite:dbname=../cpandb.sql";
my $schema = FPW12::DBIC->connect($datasource);

my $t0 = time;

my $rs = $schema->resultset('Auth')->search(
  undef,
  {columns => [qw/cpanid fullname/],
   join    => {dists => 'mods'},
   '+columns' => [{dist_name  => 'dists.dist_name',
                   mod_name   => 'mods.mod_name'}],
   },
);

my $n_rows = 0;
my $cursor = $rs->cursor;
while (my @vals = $cursor->next) {
  $n_rows++;
  print @vals;
}

my $t1 = time;

printf STDERR "%d rows in %0.5f secs\n", $n_rows, $t1-$t0;

# 113895 rows in 15.50000 secs





