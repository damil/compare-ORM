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
  {columns => [qw/auth_id cpanid fullname/],
   },
);

my $n_rows = 0;
while (my $row = $rs->next) {
  foreach my $dist ($row->dists) {
    foreach my $mod ($dist->mods) {
      $n_rows++;
      print $row->cpanid, $row->fullname, 
        $dist->dist_name,
        $mod->mod_name;
    }
  }
}

my $t1 = time;

printf STDERR "%d rows in %0.5f secs\n", $n_rows, $t1-$t0;

# 109460 rows in 46.70313 secs




