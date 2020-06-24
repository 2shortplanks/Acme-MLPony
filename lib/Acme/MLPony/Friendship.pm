package Acme::MLPony::Friendship;

use Filter::Simple;
use Acme::MLPony::Util qw( unpony );

FILTER {    
    $_ = unpony( $_ )
}

1;