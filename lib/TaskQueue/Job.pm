use strict;
use warnings;
package TaskQueue::Job;
use vars qw($AUTOLOAD);
sub new {
    my $clss = shift;
    my $self = shift;
    return bless $self, $clss;
}

sub AUTOLOAD {
    my $self = shift;
    my $setter = shift;
    unless(ref($self)) { die("Not a class method. Call on the object"); }
    my ($field) = $AUTOLOAD =~ m/([^:]+)$/;
    unless (exists $self->{$field}) { return undef; }
    {
        no strict 'refs';
        *{$AUTOLOAD} = sub { 
            my $self = shift;
            my $setter = shift;
            if(defined($setter)) {
                $self->{$field} = $setter;
            }
            return $self->{$field};
        };
    }
    $self->{$field} = $setter if(defined($setter));
    return $self->{$field};
}

sub DESTROY {}

1;
