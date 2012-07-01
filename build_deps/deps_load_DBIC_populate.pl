use strict;
use warnings;
use 5.010;
use Time::HiRes qw/time/;


use lib "..";
use FPW12::DBIC;

use constant N_SLICE => 500;

open my $DP, "deps.tsv" or die $!;
my @lines = <$DP>;

my $schema = FPW12::DBIC->connect("dbi:SQLite:dbname=../cpandb.sql");

my $dbh = $schema->storage->dbh;

$dbh->do('PRAGMA foreign_keys = ON');
$dbh->do('DROP TABLE IF EXISTS depends');
$dbh->do(<<"");
CREATE TABLE depends (
  dist_id INTEGER REFERENCES dists(dist_id),
  mod_id  INTEGER REFERENCES mods(mod_id),
  PRIMARY KEY (dist_id, mod_id)
)

my $rs = $schema->resultset('Depends');

my $t0 = time;
while (my @slice = splice(@lines, 0, N_SLICE)) {
  print STDERR ".";

  chomp foreach @slice;
  my @to_insert = map {[split /\t/]} @slice;
  my $insert_slice = sub {
    $rs->populate([[qw/dist_id mod_id/], @to_insert]);
  };

  $schema->txn_do($insert_slice);
}

my $t1 = time;

printf STDERR "done in %0.5f secs\n", $t1-$t0;
