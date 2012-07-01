use strict;
use warnings;
use 5.010;
use Time::HiRes qw/time/;
use DBI;

use lib "..";
use FPW12::DBIDM;

use constant N_SLICE => 500;

open my $DP, "deps.tsv" or die $!;
my @lines = <$DP>;

my $dbh = DBI->connect("dbi:SQLite:dbname=../cpandb.sql", '', '', 
                       {RaiseError => 1});
my $schema = FPW12::DBIDM->singleton;

$schema->dbh($dbh);

$dbh->do('PRAGMA foreign_keys = ON');
$dbh->do('DROP TABLE IF EXISTS depends');
$dbh->do(<<"");
CREATE TABLE depends (
  dist_id INTEGER REFERENCES dists(dist_id),
  mod_id  INTEGER REFERENCES mods(mod_id),
  PRIMARY KEY (dist_id, mod_id)
)

my $rs = $schema->table('Depends');

my $t0 = time;
while (my @slice = splice(@lines, 0, N_SLICE)) {
  print STDERR ".";

  my $insert_slice = sub {
    foreach my $line (@slice) {
      chomp $line;
      my ($dist_id, $mod_id) = split /\t/, $line;
      $rs->insert({
        dist_id => $dist_id,
        mod_id  => $mod_id,
        }
       );
    }
  };


  chomp foreach @slice;
  my @to_insert = map {[split /\t/]} @slice;
  $schema->do_transaction($insert_slice);
}

my $t1 = time;

printf STDERR "done in %0.5f secs\n", $t1-$t0;
