## no critic (RequireVersionVar, RequireExplicitPackage)
use strict;

use warnings;
use Test;

# use a BEGIN block so we print our plan before MyModule is loaded
BEGIN { plan tests => 8 }

# load your module...
use Config qw(
  parse_arguments
  setup_logger
  setup_endpoint
  setup_framework
  setup_id_type
  setup_class
  setup_com
);

{
    my @args = ('bar');

    my $parsed = parse_arguments( \@args );

    ok( $parsed->{filename} eq 'bar' );
}

{
    my $line = 'L yes';
    my $mock_state = { 'logger' => -1 };
    setup_logger( $line, $mock_state );
    ok( $mock_state->{'logger'}, 1 );
}

{
    my $line = 'L no';
    my $mock_state = { 'logger' => -1 };
    setup_logger( $line, $mock_state );
    ok( $mock_state->{'logger'}, 0 );
}

{
    my $line = 'E /v1/';
    my $mock_state = { 'endpoint' => -1 };
    setup_endpoint( $line, $mock_state );
    ok( $mock_state->{'endpoint'} eq '/v1/' )
}

{
    my $line = 'F alphabeta';
    my $mock_state = { 'framework' => -1 };
    setup_framework( $line, $mock_state );
    ok( $mock_state->{'framework'} eq 'alphabeta' );
}

{
    my $line = 'F string';
    my $mock_state = { 'type' => -1 };
    setup_id_type( $line, $mock_state );
    ok( $mock_state->{'type'} eq 'string' );
}

{
    my $line = 'C Animal';
    my $mock_state = { 'class_name' => -1 };
    setup_class( $line, $mock_state );
    ok( $mock_state->{'class_name'} eq 'Animal' )
}

{
    setup_com();
    ok( 1 == 1 )
}

1;
