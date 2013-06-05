use strict;
use warnings;
package TaskQueue;
use Time::HiRes qw(sleep);
use TaskQueue::JobList;
use overload '""' => \&_strify;

sub new {
    my $clss = shift;
    my $_jobList = TaskQueue::JobList->new;
    my $self = {
        _jobs => $_jobList->collect,
        _jobList => $_jobList
    };
    return bless $self, $clss;
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

sub _strify {
    use Data::Dump;
    my $self = shift;
    dd($self->{_jobs});
}

1;
