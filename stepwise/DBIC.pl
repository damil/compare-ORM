use strict;
use warnings;
use 5.010;

use lib "..";
use FPW12::DBIC;

my $datasource = "dbi:SQLite:dbname=../cpandb.sql";
my $schema = FPW12::DBIC->connect($datasource);

BEGIN {$ENV{DBI_TRACE} = 1}

my $dists = $schema->resultset('Dist')->search(
  {dist_name => {-like => 'DBIx%'}},
);

my $big_vers = $dists->search({dist_vers => { ">" => 0}}); # 2}});

my @auths = $big_vers->search_related('auth', undef, {distinct => 1,
                                                      order_by => 'fullname'});

say $_->fullname foreach @auths;


