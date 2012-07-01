use strict;
use warnings;
use 5.010;

use lib "..";
use FPW12::DBIDM;
use DBI;

my $datasource = "dbi:SQLite:dbname=../cpandb.sql";
my $dbh = DBI->connect($datasource, "", "", {RaiseError => 1, AutoCommit => 1});
FPW12::DBIDM->dbh($dbh);

my $auth1 = FPW12::DBIDM::Auth->fetch(123);
my $auth2 = FPW12::DBIDM::Auth->select(
  -where => {cpanid => 'DAMI'},
  -result_as => 'firstrow',
);

say $auth1->{fullname};
say $auth2->{fullname};


my $dists = $auth2->dists(-order_by => 'dist_name');

foreach my $dist (@$dists) {
  say "  ", $dist->{dist_name};
}
