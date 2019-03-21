#line 1 Rest/Get.pm
package Rest::Get;
use 5.010;

use strict;
use warnings;

our $VERSION = 1.0;

use base 'Exporter';
our @EXPORT_OK = qw(gen_get);

sub gen_get {
    my %state_ref = @_;

    my $class_name = $state_ref{'class_name'};
    my $endpoint   = $state_ref{'endpoint'};
    my $id_type    = $state_ref{'type'};

    my $ret = "get(id: ${id_type}): Observable<$class_name> {\n";
    if ( $state_ref{'logger'} ) {
        $ret = $ret . "  log.debug(`Retrieving the ${class_name} with id \$\{id\}`);\n";
    }
    $ret = $ret . "  return this.http.get<${class_name}>(`${endpoint}\/\$\{id\}`);\n";
    $ret = $ret . "}\n\n";
    return $ret;
}

1;
