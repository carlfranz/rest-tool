#line 1 Config.pm
package Config;

use 5.010;

use strict;
use warnings;
use Data::Dumper;

our $VERSION = 1.0;

use base 'Exporter';
our @EXPORT_OK = qw(
  parse_arguments
  read_conf
  setup_logger
  setup_endpoint
  setup_framework
  setup_id_type
  setup_class
  setup_com
);

use Carp;

sub parse_arguments {
    my ($argv_ref) = @_;
    my $args_ref = {};

    my $size = @{$argv_ref};
    if ( $size != 1 ) {
        croak 'Errore argv';
    }
    $args_ref->{'filename'} = @{$argv_ref}[0];
    return $args_ref;
}

sub setup_logger {
    my ( $line, $state_ref ) = @_;

    my $str = substr $line, 1;
    $str =~ s/^\s+|\s+$//xmsg;    #trim both ends
    if ( $str eq 'yes' ) {
        $state_ref->{'logger'} = 1;
    }
    else {
        $state_ref->{'logger'} = 0;
    }
    return $state_ref;
}

sub setup_endpoint {
    my ( $line, $state_ref ) = @_;
    my $str = substr $line, 1;
    $str =~ s/^\s+|\s+$//xmsg;    #trim both ends
    $state_ref->{'endpoint'} = $str;
    return $state_ref;
}

sub setup_framework {
    my ( $line, $state_ref ) = @_;
    my $str = substr $line, 1;
    $str =~ s/^\s+|\s+$//xmsg;    #trim both ends
    $state_ref->{'framework'} = $str;
    return $state_ref;
}

sub setup_id_type {
    my ( $line, $state_ref ) = @_;
    my $str = substr $line, 1;
    $str =~ s/^\s+|\s+$//xmsg;    #trim both ends
    $state_ref->{'type'} = $str;
    return $state_ref;
}

sub setup_class {
    my ( $line, $state_ref ) = @_;
    my $str = substr $line, 1;
    $str =~ s/^\s+|\s+$//xmsg;    #trim both ends
    $state_ref->{'class_name'} = $str;
    return $state_ref;
}

sub setup_com {

    # just a comment :)
    return;
}

my %actions = (
    q{L} => \&setup_logger,
    q{E} => \&setup_endpoint,
    q{F} => \&setup_framework,
    q{T} => \&setup_id_type,
    q{C} => \&setup_class,
    q{#} => \&setup_com,
);

sub handle_line {
    my ( $line, $state_ref ) = @_;

    chomp $line;
    my $c = ucfirst substr $line, 0, 1;

    if ($c) {
        my $code = $actions{$c} or do { croak 'Invalid char found!' };
        my $res = $code->( $line, $state_ref );
    }
    return;
}

sub read_conf {
    my ( $state_ref, $args_ref ) = @_;
    my $filename = $args_ref->{'filename'};

    open my $fh, '<', $filename
      or croak "Could not open $filename for reading.";

    while ( my $line = readline $fh ) {
        handle_line( $line, $state_ref );
    }
    close $fh or carp "Could not close $filename.";

    return;
}

1;
