## no critic (RequireVersionVar, RequireExplicitPackage)
use strict;

use warnings;
use Test;

# use a BEGIN block so we print our plan before MyModule is loaded
BEGIN { plan tests => 1 }

# load your module...
use Rest::List qw(gen_list);

my %test_conf = (
    framework  => 'angular',
    type       => 'string',
    class_name => 'RestCaProxy',
    endpoint   => '/rest/v1/proxies',
    logger     => 1,
);

my $result = gen_list(%test_conf);
my $expected =
    qq|list(): Observable<RestCaProxy[]> {\n|
  . qq|  log.debug('Retrieving a list of RestCaProxy from server');\n|
  . qq|  return this.http.get<RestCaProxy[]>('/rest/v1/proxies');\n|
  . qq|}\n\n|;

ok( $result eq $expected );

1;
