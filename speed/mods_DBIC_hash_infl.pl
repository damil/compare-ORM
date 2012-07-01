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

my $rs = $schema->resultset('Mod')->search(
  undef,
  {columns => [qw/mod_name mod_vers/]},
);
$rs->result_class('DBIx::Class::ResultClass::HashRefInflator');

my $n_rows = 0;
while (my $row = $rs->next) {
  $n_rows++;
  print @{$row}{qw/mod_name mod_vers/};
}

my $t1 = time;

printf STDERR "%d rows in %0.5f secs\n", $n_rows, $t1-$t0;

# 109349 rows in 10.06250 secs






