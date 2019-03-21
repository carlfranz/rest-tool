#line 1 Rest/List.pm
package Rest::List;
use 5.010;

use strict;
use warnings;

our $VERSION = 1.0;

use base 'Exporter';
our @EXPORT_OK = qw(gen_list);

sub gen_list {
    my %state_ref = @_;

    my $class_name = $state_ref{'class_name'};
    my $endpoint   = $state_ref{'endpoint'};

    my $ret = qq|list(): Observable<$class_name\[\]> {\n|;
    if ( $state_ref{'logger'} ) {
        $ret = qq|$ret  log.debug('Retrieving a list of ${class_name} from server');\n|;
    }
    $ret = qq|$ret  return this.http.get<${class_name}\[\]>(\'${endpoint}\');\n|;
    $ret = qq|$ret}\n\n|;
    return $ret;
}

1;
