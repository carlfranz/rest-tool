## no critic (RequireVersionVar, RequireExplicitPackage)
use strict;
use warnings;
use Test;

use 5.010;

BEGIN { plan tests => 1 }    # before module load

use Rest::Remove qw(gen_remove);

my %test_conf = (
    framework  => 'angular',
    type       => 'string',
    class_name => 'RestCaProxy',
    endpoint   => '/rest/v1/proxies',
    logger     => 1,
);

my $result = gen_remove(%test_conf);

my $expected =
    qq|remove(id: string): Observable<{}> {\n|
  . qq|  log.debug(`Deleting the RestCaProxy with id \${id}`);\n|
  . qq|  return this.http.delete<{}>(`/rest/v1/proxies/\${id}`);\n|
  . qq|}\n\n|;

ok( $result eq $expected );

1;
