use strict;
use warnings;
use 5.010;

use lib "..";
use FPW12::DBIDM;
use DBI;

my $datasource = "dbi:SQLite:dbname=../cpandb.sql";
my $dbh = DBI->connect($datasource, "", "", {RaiseError => 1, AutoCommit => 1});
FPW12::DBIDM->dbh($dbh);

my $stmt = FPW12::DBIDM::Dist->select(
  -where     => {dist_name => {-like => 'DBIx%'}},
  -result_as => 'statement',
);

my $subquery = $stmt->select(
  -columns   => 'auth_id',
  -where     => {dist_vers => { ">" => 2}},
  -result_as => 'subquery',
);

my $auths = FPW12::DBIDM::Auth->select(
  -columns => 'fullname',
  -where => {auth_id => {-in => $subquery}},
);

say $_->{fullname} foreach @$rows;


