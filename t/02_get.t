## no critic (RequireVersionVar, RequireExplicitPackage)
use strict;

use warnings;
use Test;

BEGIN { plan tests => 1 }    # before module load

use Rest::Get qw(gen_get);

my %test_conf = (
    framework  => 'angular',
    type       => 'string',
    class_name => 'RestCaProxy',
    endpoint   => '/rest/v1/proxies',
    logger     => 1,
);

my $result = gen_get(%test_conf);
my $expected =
    qq|get(id: string): Observable<RestCaProxy> {\n|
  . qq|  log.debug(`Retrieving the RestCaProxy with id \${id}`);\n|
  . qq|  return this.http.get<RestCaProxy>(`/rest/v1/proxies/\${id}`);\n|
  . qq|}\n\n|;

ok( $result eq $expected );

1;
