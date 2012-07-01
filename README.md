Comparision of DBIx::Class and DBIx::DataModel
=============================================

This directory contains a number of scripts that were used to
experiment with and benchmark relative performances of DBIx::Class
(a.k.a DBIC) and DBIx::DataModel (a.k.a DBIDM). See slides at
http://www.slideshare.net/ldami/dbixclass-vs-dbixdatamodel.
This talk was for the French Perl Workshop 2012, hence the namespace
FPW12 for classes.

CONTENTS
========

README.txt      the present file

cpandb.sql      copy of a SQLite database generated from CPAN:SQLite

FPW12: classes for accessing the database through DBIC or DBIDM

build_deps:     scripts for benchmarking addition of a 'depends' table.
                Data is in 'deps.tsv', and is built by script 
                'extract_deps_from_META.pl' which extracts dependencies 
                from a local minicpan installation (see CPAN::Mini).

find:           example scripts for fetching a single record

search:         example scripts for some simple searches

stepwise:       example scripts for chained resultsets

find_deps_DBIC: example scripts using DBIC for many-to-many searches

speed:          benchmarking various search operations

  NOTE : to run benchmarks, redirect STDOUT to a file (i.e. 
  "perl some_script.pl >foo.txt), in order to avoid artificial
  differences that may be due to the STDOUT console.


BENCHMARK RESULTS
=================

Extract & print 2 columns from a single table (109349 rows)
  - raw DBI                    0.43 secs
  - DBIC regular              11.09 secs
  - DBIC hashref inflator     10.06 secs    
  - DBIC 'raw data' (cursor)   4.48 secs
  - DBIDM regular              4.00 secs
  - DBIDM fast statement       2.25 secs

Join 3 tables & print 4 columns from the join (113895 rows)
  - raw DBI                                     1.36 secs
  - DBIC regular                               46.70 secs
  - DBIC, join & +columns                      15.50 secs
  - DBIC, join & +columns, hashref inflator    14.17 secs
  - DBIC, join & +columns, 'raw data' (cursor)  6.59 secs
  - DBIC, prefetch                            146.29 secs
  - DBIDM regular                               5.01 secs
  - DBIDM fast statement                        3.28 secs



