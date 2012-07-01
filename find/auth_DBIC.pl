use strict;
use warnings;
use 5.010;

use lib "..";
use FPW12::DBIC;

my $schema = FPW12::DBIC->connect("dbi:SQLite:dbname=../cpandb.sql");

my $auth1 = $schema->resultset('Auth')->find(123);
my $auth2 = $schema->resultset('Auth')->find({cpanid => 'DAMI'});

say $auth1->fullname;
say $auth2->fullname;

my @dists = $auth2->dists(undef, {order_by => 'dist_name'});

foreach my $dist (@dists) {
  say "  ", $dist->dist_name;
}

