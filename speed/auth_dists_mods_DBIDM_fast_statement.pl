use strict;
use warnings;
use 5.010;

use lib "..";
use FPW12::DBIDM;
use DBI;
no warnings 'uninitialized';
$\ = "\n";
$, = "\t";
use Time::HiRes qw/time/;

my $datasource = "dbi:SQLite:dbname=../cpandb.sql";
my $dbh = DBI->connect($datasource, "", "", {RaiseError => 1, AutoCommit => 1});
FPW12::DBIDM->dbh($dbh);

my $t0 = time;

my $stmt = FPW12::DBIDM->join(qw/Auth dists mods/)->select(
  -columns   => [qw/cpanid fullname dist_name mod_name/],
  -result_as => 'fast_statement',
);

my $n_rows = 0;
while (my $row = $stmt->next) {
  $n_rows++;
  print @{$row}{qw/cpanid fullname dist_name mod_name/};
}

my $t1 = time;

printf STDERR "%d rows in %0.5f secs\n", $n_rows, $t1-$t0;



