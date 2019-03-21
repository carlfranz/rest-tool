## no critic (RequireVersionVar, RequireExplicitPackage)
use strict;
use warnings;
use Test;

use 5.010;

BEGIN { plan tests => 1 }    # before module load

use Rest::Create qw(gen_create);

my %test_conf = (
    framework  => 'angular',
    type       => 'string',
    class_name => 'RestCaProxy',
    endpoint   => '/rest/v1/proxies',
    logger     => 1,
);

my $result = gen_create(%test_conf);

my $expected =
    qq|create(restCaProxy: RestCaProxy): Observable<RestCaProxy> {\n|
  . qq|  log.debug('Creating a new RestCaProxy');\n|
  . qq|  return this.http.post<RestCaProxy>('/rest/v1/proxies',restCaProxy);\n|
  . qq|}\n\n|;

ok( $result eq $expected );

1;
