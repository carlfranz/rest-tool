## no critic (RequireVersionVar, RequireExplicitPackage)
use strict;
use warnings;
use Test;

use 5.010;

BEGIN { plan tests => 1 }    # before module load

use Rest::Update qw(gen_update);

my %test_conf = (
    framework  => 'angular',
    type       => 'string',
    class_name => 'RestCaProxy',
    endpoint   => '/rest/v1/proxies',
    logger     => 1,
);

my $result = gen_update(%test_conf);

my $expected =
    qq|update(id: string, restCaProxy: RestCaProxy): Observable<RestCaProxy> {\n|
  . qq|  log.debug(`Updating the RestCaProxy with id \${id}`);\n|
  . qq|  return this.http.put<RestCaProxy>(`/rest/v1/proxies/\${id}`,restCaProxy)\n|
  . qq|    .pipe(catchError(err => this.handleError(err)));\n|
  . qq|}\n\n|;

ok( $result eq $expected );

1;
