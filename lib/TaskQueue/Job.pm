use strict;
use warnings;
package TaskQueue::Job;

sub new {
    my $clss = shift;
    my $self = shift;
}

sub get_name {
    my $self = shift;
    return $self->{name};
}
