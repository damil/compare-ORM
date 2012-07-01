use strict;
use warnings;
use 5.010;

use lib "..";
use FPW12::DBIDM;
use DBI;

my $datasource = "dbi:SQLite:dbname=../cpandb.sql";
my $dbh = DBI->connect($datasource, "", "", {RaiseError => 1, AutoCommit => 1});
FPW12::DBIDM->dbh($dbh);

my $stmt = FPW12::DBIDM->join(qw/Dist auth/)->select(
  -where     => {dist_name => {-like => 'DBIx%'}},
  -result_as => 'statement',
);

$stmt->refine(
  -columns   => [-DISTINCT => 'fullname'],
  -where     => {dist_vers => { ">" => 0}},
  -order_by  => 'fullname',
);

say $_->{fullname} while $_ = $stmt->next;



