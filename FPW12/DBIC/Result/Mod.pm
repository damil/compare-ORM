use utf8;
package FPW12::DBIC::Result::Mod;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("mods");

__PACKAGE__->add_columns(
  "mod_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "chapterid",
  { data_type => "integer", is_nullable => 1 },
  "dslip",
  { data_type => "varchar", is_nullable => 1, size => 5 },
  "mod_vers",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "dist_id",
  { data_type => "integer", is_nullable => 0 },
  "mod_abs",
  { data_type => "text", is_nullable => 1 },
  "mod_name",
  { data_type => "varchar", is_nullable => 0, size => 100 },
);


__PACKAGE__->set_primary_key("mod_id");

__PACKAGE__->belongs_to('dist', 'FPW12::DBIC::Result::Dist', 'dist_id');
__PACKAGE__->has_many('inv_depends', 'FPW12::DBIC::Result::Depends', 'mod_id');
__PACKAGE__->many_to_many(used_in_dist => 'depends', 'dist');

1;


__END__

=head1 NAME

FPW12::DBIC::Result::Mod

=head1 TABLE: C<mods>

=head1 ACCESSORS

=head2 mod_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 chapterid

  data_type: 'integer'
  is_nullable: 1

=head2 dslip

  data_type: 'varchar'
  is_nullable: 1
  size: 5

=head2 mod_vers

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 dist_id

  data_type: 'integer'
  is_nullable: 0

=head2 mod_abs

  data_type: 'text'
  is_nullable: 1

=head2 mod_name

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head1 PRIMARY KEY

=over 4

=item * L</mod_id>

=back



