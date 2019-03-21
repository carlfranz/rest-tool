#line 1 Rest/Update.pm
package Rest::Update;
use 5.010;

use strict;
use warnings;

our $VERSION = 1.0;

use base 'Exporter';
our @EXPORT_OK = qw(gen_update);

sub gen_update {
    my %state_ref = @_;

    my $cname    = $state_ref{'class_name'};
    my $endpoint = $state_ref{'endpoint'};
    my $type     = $state_ref{'type'};         #id type
    my $d        = lcfirst $cname;

    my $ret = qq|update(id: $type, $d: $cname): Observable<$cname> {\n|;
    if ( $state_ref{'logger'} ) {
        $ret = qq|$ret  log.debug(`Updating the $cname with id \${id}`);\n|;
    }
    $ret = qq|$ret  return this.http.put<$cname>(`$endpoint/\${id}`,$d);\n|;
    $ret = qq|$ret}\n\n|;
    return $ret;
}

1;

