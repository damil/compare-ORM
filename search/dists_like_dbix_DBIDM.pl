use strict;
use warnings;
use 5.010;

use lib "..";
use FPW12::DBIDM;
use DBI;

my $datasource = "dbi:SQLite:dbname=../cpandb.sql";
my $dbh = DBI->connect($datasource, "", "", {RaiseError => 1, AutoCommit => 1});
FPW12::DBIDM->dbh($dbh);

my $dists = FPW12::DBIDM::Dist->select(
  -columns => [qw/dist_name dist_vers/],
  -where   => {dist_name => {-like => 'DBIx%'}},
);

foreach my $dist (@$dists) {
  print "$dist->{dist_name} ($dist->{dist_vers})\n";
}

