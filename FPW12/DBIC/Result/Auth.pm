use utf8;
package FPW12::DBIC::Result::Auth;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FPW12::DBIC::Result::Auth

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<auths>

=cut

__PACKAGE__->table("auths");

=head1 ACCESSORS

=head2 auth_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 email

  data_type: 'text'
  is_nullable: 1

=head2 fullname

  data_type: 'varchar'
  is_nullable: 0
  size: 40

=head2 cpanid

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=cut

__PACKAGE__->add_columns(
  "auth_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "email",
  { data_type => "text", is_nullable => 1 },
  "fullname",
  { data_type => "varchar", is_nullable => 0, size => 40 },
  "cpanid",
  { data_type => "varchar", is_nullable => 0, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</auth_id>

=back

=cut

__PACKAGE__->set_primary_key("auth_id");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-06-23 04:30:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:quvc/8vjSLyVuB6IInjR2w

__PACKAGE__->has_many  ('dists', 'FPW12::DBIC::Result::Dist',  'auth_id');


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
