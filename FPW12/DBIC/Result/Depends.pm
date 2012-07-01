use utf8;
package FPW12::DBIC::Result::Depends;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("depends");

__PACKAGE__->add_columns(
  "dist_id",
  { data_type => "integer", is_nullable => 0 },
  "mod_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
);


__PACKAGE__->set_primary_key(qw/dist_id mod_id/);

__PACKAGE__->belongs_to('dist', 'FPW12::DBIC::Result::Dist', 'dist_id');
__PACKAGE__->belongs_to('mod',  'FPW12::DBIC::Result::Mod',  'mod_id');


1;

__END__

=head1 NAME

FPW12::DBIC::Result::Depends

