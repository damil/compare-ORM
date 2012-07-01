use strict;
use warnings;
use 5.010;
use Time::HiRes qw/time/;


use DBI;

use constant N_SLICE => 500;

open my $DP, "deps.tsv" or die $!;
my @lines = <$DP>;

my $dbh = DBI->connect("dbi:SQLite:dbname=../cpandb.sql");

$dbh->do('PRAGMA foreign_keys = ON');
$dbh->do('DROP TABLE IF EXISTS depends');
$dbh->do(<<"");
CREATE TABLE depends (
  dist_id INTEGER REFERENCES dists(dist_id),
  mod_id  INTEGER REFERENCES mods(mod_id),
  PRIMARY KEY (dist_id, mod_id)
)


my $t0 = time;
while (my @slice = splice(@lines, 0, N_SLICE)) {
  print STDERR ".";
  chomp foreach @slice;
  my @to_insert = map {[split /\t/]} @slice;

  $dbh->begin_work;
  my $sth = $dbh->prepare("INSERT INTO depends(dist_id, mod_id) VALUES (?, ?)");

  # my first try was a plain ->execute() ... already fairly good results
  #  $sth->execute(@$_) foreach @to_insert;

  # using execute_array() ... no big difference
  $sth->bind_param_array(1, [map {$_->[0]} @to_insert]);
  $sth->bind_param_array(2, [map {$_->[1]} @to_insert]);
  $sth->execute_array({})
    or die $sth->errstr;

  $dbh->commit;
}

my $t1 = time;

printf STDERR "done in %0.5f secs\n", $t1-$t0;
