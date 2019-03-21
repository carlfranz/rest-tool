#!/usr/bin/perl

use 5.010;

use strict;
use warnings;
use Data::Dumper;

our $VERSION = 1.0.0;

use Config qw(
  parse_arguments
  read_conf
);

use Rest::List qw(gen_list);
use Rest::Get qw(gen_get);
use Rest::Create qw(gen_create);
use Rest::Remove qw(gen_remove);
use Rest::Update qw(gen_update);

my %state = (
    framework  => 'angular',
    type       => 'string',
    class_name => 'RestCaProxy',
    endpoint   => '/rest/v1/proxies',
    logger     => 1,
);

my $argv_ref  = \@ARGV;
my $state_ref = \%state;

my $mapped_ref = parse_arguments($argv_ref);
read_conf( $state_ref, $mapped_ref );

my $res =                 #
  gen_list(%state)        #
  . gen_get(%state)       #
  . gen_create(%state)    #
  . gen_update(%state)    #
  . gen_remove(%state);

#do print $res;
1;
