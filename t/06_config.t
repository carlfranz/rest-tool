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
    setup_endpoint();
    ok( 1 == 1 )
}

{
    setup_framework();
    ok( 1 == 1 )
}

{
    setup_id_type();
    ok( 1 == 1 )
}

{
    setup_class();
    ok( 1 == 1 )
}

{
    setup_com();
    ok( 1 == 1 )
}

1;
