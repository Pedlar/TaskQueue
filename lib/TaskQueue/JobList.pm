use strict;
use warnings;
package TaskQueue::JobList;
use TaskQueue::Job;
use TaskQueue::SQLite;

sub new {
    my $clss = shift;
    my $self = {
        _queue => '',
    };
    return bless $self, $clss;
}

sub collect {
    my $self = shift;
    my $list = TaskQueue::SQLite::get_jobs;
    my @queue;
    foreach (@{$list}) {
        my $job = TaskQueue::Job->new($_);
        push @queue, $job;
    }
    $self->{_queue} = \@queue;
    return [@queue];
}

1;
