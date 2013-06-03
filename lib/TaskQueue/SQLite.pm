use strict;
use warnings;
package TaskQueue::SQLite;

use DBI;
use Memoize;
memoize('dbh');

sub dbh {
    my $dir = (getpwuid($<))[7] . "/.taskqueue"; 
    my $dbfile = $dir . "/queue.sql";
    my $first_run = 0;
    unless(-e $dir) {
        mkdir($dir);
    }
    unless(-e $dbfile) {
       $first_run = 1;
    }
    my $dbh = DBI->connect("dbi:SQLite:dbname=$dbfile","","") or die DBI::errstr;
    if($first_run) {
        _create_schema($dbh);
    }
    return $dbh;
}

sub get_jobs {
    return dbh->selectall_arrayref("SELECT * FROM jobs", { Slice => {} });    
}

sub add_job {
    my %params = @_;
    dbh->do("INSERT INTO jobs (name, command, repeat, one_time, run_one) VALUES(?, ?, ?, ?, ?)", undef,
            $params{name},
            $params{command},
            $params{repeat},
            $params{repeat} == 0 ? 1 : $params{one_time},
            $params{run_one} // 0);
}

sub _create_schema {
    my $dbh = shift;
    #TODO: Create Schema for jobs
    my $schema = <<SCHEMA;
CREATE TABLE jobs (
    id INTEGER PRIMARY KEY,
    name TEXT,
    command TEXT,
    repeat INTEGER,
    last_run INTEGER,
    next_run INTEGER,
    one_time INTEGER,
    run_one  INTEGER
);
SCHEMA
    $dbh->do($schema) or die DBI::errstr;
}
