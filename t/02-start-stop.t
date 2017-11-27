#!perl -w
use strict;
use warnings;
use LWP::Simple qw(get);
use Test::HTTP::LocalServer;

use Test::More tests => 2;

my $server = Test::HTTP::LocalServer->spawn;

my $pid = $server->{_pid};
my $res = kill 0, $pid;
is $res, 1, "PID $pid is an existing process";

$server->stop;

$res = kill 0, $pid;
is $res, 0, "PID $pid doesn't exist anymore";