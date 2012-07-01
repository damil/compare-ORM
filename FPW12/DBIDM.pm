use strict;
use warnings;
use DBIx::DataModel;

DBIx::DataModel  # no semicolon (intentional)

#---------------------------------------------------------------------#
#                         SCHEMA DECLARATION                          #
#---------------------------------------------------------------------#
->Schema('FPW12::DBIDM')

#---------------------------------------------------------------------#
#                         TABLE DECLARATIONS                          #
#---------------------------------------------------------------------#
#          Class   Table   PK
#          =====   =====   ==
->Table(qw/Auth    auths   auth_id       /)
->Table(qw/Chap    chaps   chap_id       /)
->Table(qw/Depends depends dist_id mod_id/)
->Table(qw/Dist    dists   dist_id       /)
->Table(qw/Mod     mods    mod_id        /)

#---------------------------------------------------------------------#
#                      ASSOCIATION DECLARATIONS                       #
#---------------------------------------------------------------------#
#                Class   Role  Mult
#                =====   ====  ====
->Association([qw/Auth     auth         1                   /],
              [qw/Dist     dists        *                   /])
->Composition([qw/Dist     dist         1                   /],
              [qw/Mod      mods         *                   /])
->Association([qw/Dist     dist         1                   /],
              [qw/Depends  depends      *                   /])
->Association([qw/Mod      mod          1                   /],
              [qw/Depends  depends      *                   /])
->Association([qw/Dist     used_in_dist *   depends distrib /],
              [qw/Mod      prereq_mods  *   depends mod     /])
;

#---------------------------------------------------------------------#
#                             COLUMN TYPES                            #
#---------------------------------------------------------------------#
# FPW12::DBIDM->ColumnType(ColType_Example =>
#   fromDB => sub {...},
#   toDB   => sub {...});

# FPW12::DBIDM::SomeTable->ColumnType(ColType_Example =>
#   qw/column1 column2 .../);


1;
