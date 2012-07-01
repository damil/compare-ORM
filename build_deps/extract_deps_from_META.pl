# extract_deps_from_META.pl: parse META.yml files from CPAN distributions and
# build a table of dependencies in a flat file.
# laurent.dami@justice.ge.ch, June 2012
use strict;
use warnings;
use YAML            qw//;
use lib "..";
use FPW12::DBIC;

# EDIT BELOW to suit your settings
my $cpandb      = "dbi:SQLite:dbname=../cpandb.sql";
my $dist_root   = "/D/strawberry/minicpan/authors/id";
my $tar_pgm     = "tar";
my $target_file = "deps.tsv";

# map of modules not found in CPANDB. Initially loaded with some 
# modules from perl core, commonly referred from META.yml files.
my %mod_not_found;
$mod_not_found{$_} = 1 for qw/perl warnings strict B DynaLoader File::Basename 
                              FindBin/;

# open flat file and connection to cpandb;
open my $DEPS, ">", $target_file
  or die $!;
my $schema = FPW12::DBIC->connect($cpandb);

# iterate over all distributions
my $dists = $schema->resultset('Dist')->search;
DIST:
while (my $dist = $dists->next) {
  print STDERR $dist->dist_name;

  # find location of archive file for this distribution
  my $dist_id   = $dist->dist_id;
  my $cpanid    = $dist->auth->cpanid;
  my @auth_dir  = (substr($cpanid, 0, 1), substr($cpanid, 0, 2), $cpanid);
  my $dist_path = join "/", $dist_root, @auth_dir, $dist->dist_file;
  my $meta_path = $dist->dist_name . "-" . $dist->dist_vers . "/META.yml";

  # get list of modules required by this distribution, from its META.yml
  my $meta_content = get_meta_from_tar($dist_path, $meta_path)
    or print STDERR " .. NO META\n"  and next DIST;
  my $meta = eval {YAML::Load $meta_content}
    or print STDERR ".. could not parse $meta_path : $@\n" and next DIST;
  my $requires = $meta->{requires} || {};
  ref $requires or $requires = {$requires => 0};

  # for each required module, generate a dependency line
 PREREQ:
  foreach my $prereq (keys %$requires) {
    next PREREQ if $mod_not_found{$prereq};
    if (my $mod = $schema->resultset('Mod')->by_mod_name($prereq)) {
      my $mod_id = $mod->mod_id;
      print $DEPS "$dist_id\t$mod_id\n";
    }
    else {
      $mod_not_found{$prereq} = 1;
    }
  }

  print STDERR " .. OK \n";
}

# use external 'tar' program to extract NETA.yml from archive. I tried
# Archive::Peek or Archive::Tar, but 'tar' is much faster and doesn't end
# up with "out of memory".
sub get_meta_from_tar {
  my ($path, $meta_path) = @_;
  open my $fh, "$tar_pgm --extract --gzip --to-stdout --file=$path $meta_path |"
    or die $!;
  local $/ = undef;
  my $content = <$fh>;
  return $content;
}
