use strict;
use warnings;
package TaskQueue;
use Time::HiRes qw(sleep);
use TaskQueue::JobList;

sub new {
    my $self = {
        _jobs => TaskQueue::JobList::collect,
    }
}

sub has_jobs {
    my $self = shift;
    return scalar($self->{_jobs});
}

sub start {
    my $self = shift;
    while (1) {
        if($self->has_jobs) {
            #$self->execute_next_job();
            #TODO: Handle Jobs
        } else {
            #Sleep for 300ms while waiting
            sleep 300;
        }
    }
}

sub add_job {

}



1;
