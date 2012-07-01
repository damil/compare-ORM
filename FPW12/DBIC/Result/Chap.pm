use utf8;
package FPW12::DBIC::Result::Chap;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FPW12::DBIC::Result::Chap

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<chaps>

=cut

__PACKAGE__->table("chaps");

=head1 ACCESSORS

=head2 chap_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 chapterid

  data_type: 'integer'
  is_nullable: 1

=head2 subchapter

  data_type: 'text'
  is_nullable: 1

=head2 dist_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "chap_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "chapterid",
  { data_type => "integer", is_nullable => 1 },
  "subchapter",
  { data_type => "text", is_nullable => 1 },
  "dist_id",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</chap_id>

=back

=cut

__PACKAGE__->set_primary_key("chap_id");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-06-23 04:30:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LSwfLNf2IXB/FdKVcoXNjg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
