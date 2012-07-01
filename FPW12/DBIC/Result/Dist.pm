use utf8;
package FPW12::DBIC::Result::Dist;
use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("dists");

__PACKAGE__->add_columns(
  "dist_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "dist_vers",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "dist_dslip",
  { data_type => "varchar", is_nullable => 1, size => 5 },
  "dist_name",
  { data_type => "varchar", is_nullable => 0, size => 90 },
  "auth_id",
  { data_type => "integer", is_nullable => 0 },
  "dist_abs",
  { data_type => "text", is_nullable => 1 },
  "dist_file",
  { data_type => "varchar", is_nullable => 0, size => 110 },
);

__PACKAGE__->set_primary_key("dist_id");

__PACKAGE__->belongs_to  ('auth',    'FPW12::DBIC::Result::Auth',    'auth_id');
__PACKAGE__->has_many    ('mods',    'FPW12::DBIC::Result::Mod',     'dist_id');
__PACKAGE__->has_many    ('depends', 'FPW12::DBIC::Result::Depends', 'dist_id');
__PACKAGE__->many_to_many(prereq_mods => 'depends', 'mod');

1;

__END__

=head1 NAME

FPW12::DBIC::Result::Dist


=head1 TABLE: C<dists>


=head1 ACCESSORS

=head2 dist_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 dist_vers

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 dist_dslip

  data_type: 'varchar'
  is_nullable: 1
  size: 5

=head2 dist_name

  data_type: 'varchar'
  is_nullable: 0
  size: 90

=head2 auth_id

  data_type: 'integer'
  is_nullable: 0

=head2 dist_abs

  data_type: 'text'
  is_nullable: 1

=head2 dist_file

  data_type: 'varchar'
  is_nullable: 0
  size: 110


=head1 PRIMARY KEY

=over 4

=item * L</dist_id>

=back

=cut
