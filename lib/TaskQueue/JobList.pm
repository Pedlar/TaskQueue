use strict;
use warnings;
package TaskQueue::JobList;
use TaskQueue::Job;
use TaskQueue::SQLite;

sub new {
    my $clss = shift;
    $self = {
        _queue => '';
    };
}

sub collect {
    my $self = shift;
    my $list = TaskQueue::SQLite::get_jobs;
    my @queue;
    foreach (@{$list}) {
        my $job = TaskQueue::Job->new($_);
        push @queue, $job;
    }
    $self->{_queue} = @queue;
    return $self->{_queue};
}
