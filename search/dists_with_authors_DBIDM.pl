use strict;
use warnings;
use 5.010;

use lib "..";
use FPW12::DBIDM;
use DBI;

my $datasource = "dbi:SQLite:dbname=../cpandb.sql";
my $dbh = DBI->connect($datasource, "", "", {RaiseError => 1, AutoCommit => 1});
FPW12::DBIDM->dbh($dbh);

my $rows = FPW12::DBIDM->join(qw/Dist auth/)->select(
  -columns => [qw/dist_name dist_vers fullname/],
  -where   => {dist_name => {-like => 'DBIx%'}},
);

foreach my $row (@$rows) {
  print "$row->{dist_name} ($row->{dist_vers}) by $row->{fullname}\n";
}

