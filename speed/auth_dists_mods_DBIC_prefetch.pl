use strict;
use warnings;
use 5.010;

use lib "..";
use FPW12::DBIC;
no warnings 'uninitialized';
$\ = "\n";
$, = "\t";
use Time::HiRes qw/time/;

# $ENV{DBI_TRACE} = 1;

my $datasource = "dbi:SQLite:dbname=../cpandb.sql";
my $schema = FPW12::DBIC->connect($datasource);

my $t0 = time;

my $rs = $schema->resultset('Auth')->search(
  undef,
  {columns => [qw/cpanid fullname/],
   prefetch  => {dists => 'mods'},
   },
);

my $t01 = time;
printf STDERR "did prefetch in %0.5f secs\n", $t01-$t0;

my $n_rows = 0;
while (my $row = $rs->next) {

#  my $tr0 = time;

  foreach my $dist ($row->dists) {
    foreach my $mod ($dist->mods) {
      $n_rows++;
      print $row->cpanid, $row->fullname, 
        $dist->dist_name,
        $mod->mod_name;
    }
  }

  # my $tr1 = time;
  # printf STDERR "did this row in %0.5f secs\n", $tr1-$tr0;

}

my $t1 = time;

printf STDERR "%d rows in %0.5f secs\n", $n_rows, $t1-$t0;

# 109349 rows in 149.26563 secs





