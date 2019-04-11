#line 1 Rest/Create.pm
package Rest::Create;

use 5.010;

use strict;
use warnings;

our $VERSION = 1.0;

use base 'Exporter';
our @EXPORT_OK = qw(gen_create);

sub gen_create {
    my %state_ref = @_;

    my $cname    = $state_ref{'class_name'};
    my $endpoint = $state_ref{'endpoint'};
    my $d        = lcfirst $cname;

    my $ret = qq|create($d: $cname): Observable<$cname> {\n|;
    if ( $state_ref{'logger'} ) {
        $ret = qq|$ret  log.debug('Creating a new ${cname}');\n|;
    }
    $ret = qq|$ret  return this.http.post<${cname}>(\'${endpoint}\',$d)\n|;
    $ret = qq|$ret    .pipe(catchError(err => this.handleError(err)));\n}\n\n|;
    return $ret;
}

1;
