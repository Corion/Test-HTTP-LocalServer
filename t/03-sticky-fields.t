#!perl -w
use strict;
use warnings;
use Test::HTTP::LocalServer;
use HTTP::Request::Common;
use LWP::UserAgent;

use Test::More tests => 6;

my $server = Test::HTTP::LocalServer->spawn(
#    debug => 1
);

my $pid = $server->{_pid};
my $res = kill 0, $pid;
is $res, 1, "PID $pid is an existing process";

my $ua = LWP::UserAgent->new();

my $res = $ua->request( GET $server->url );
ok $res->is_success, "Retrieve " . $server->url;

$res = $ua->request( POST $server->url, [query => 'test1'] );
ok $res->is_success, "POST to " . $server->url;
like $res->decoded_content, qr/\bname="query"\s+value="test1"/, "We have sticky form fields";

my @log = $server->get_log;

cmp_ok 0+@log, '>', 0, "We have some lines in the log file";

$server->stop;

sleep 5; # just give it more time to be really sure

$res = kill 0, $pid;
is $res, 0, "PID $pid doesn't exist anymore";
