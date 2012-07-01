use strict;
use warnings;
use 5.010;

use lib "..";
use FPW12::DBIC;

my $datasource = "dbi:SQLite:dbname=../cpandb.sql";
my $schema = FPW12::DBIC->connect($datasource);


# my @dists = $schema->resultset('Dist')->search(
#   {dist_name => {-like => 'DBIx%'}},
#   {columns => [qw/dist_name dist_vers/],
#    join    => 'auth',
#    # 'select' => [qw/auth.fullname/],
#    # 'as'     => [qw/fullname/],
#    '+columns' => [{'fullname' => 'auth.fullname'}],
#    },
# );

# foreach my $dist (@dists) {
#   printf "%s (%s) by %s\n", $dist->dist_name, $dist->dist_vers,
#     $dist->get_column('fullname');
# }



# same with prefetch

my @dists = $schema->resultset('Dist')->search(
  {dist_name => {-like => 'DBIx%'}},
  {columns => [qw/dist_name dist_vers/],
   prefetch    => 'auth',
   },
);

foreach my $dist (@dists) {
  printf "%s (%s) by %s\n", $dist->dist_name, $dist->dist_vers,
    $dist->auth->fullname;
}
