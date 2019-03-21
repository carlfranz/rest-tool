#line 1 Rest/Remove.pm
package Rest::Remove;

use 5.010;

use strict;
use warnings;

our $VERSION = 1.0;

use base 'Exporter';
our @EXPORT_OK = qw(gen_remove);

sub gen_remove {
    my %state_ref = @_;

    my $class_name = $state_ref{'class_name'};
    my $endpoint   = $state_ref{'endpoint'};
    my $type       = $state_ref{'type'};         #id type

    my $ret = qq|remove(id: $type): Observable<{}> {\n|;
    if ( $state_ref{'logger'} ) {
        $ret = qq|$ret  log.debug(`Deleting the $class_name with id \${id}`);\n|;
    }
    $ret = qq|$ret  return this.http.delete<{}>(`$endpoint/\${id}`);\n|;
    $ret = qq|$ret}\n\n|;
    return $ret;
}

1;
