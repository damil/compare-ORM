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
while (my $row = $rs->next) {
  $n_rows++;
  print $row->cpanid, $row->fullname, 
    $row->get_column('dist_name'),
    $row->get_column('mod_name');
}

my $t1 = time;

printf STDERR "%d rows in %0.5f secs\n", $n_rows, $t1-$t0;

# 113895 rows in 15.50000 secs





