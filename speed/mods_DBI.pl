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

my $t0 = time;

my $sth = $dbh->prepare("SELECT mod_name, mod_vers FROM mods");
$sth->execute;

my $n_rows = 0;
while (my $row = $sth->fetchrow_arrayref) {
  $n_rows++;
  print @$row;
}

my $t1 = time;

printf STDERR "%d rows in %0.5f secs\n", $n_rows, $t1-$t0;

# 109349 rows in 0.43482 secs


