use strict;
use warnings;
use Test::More;
use IPC::Run qw(run);

run [
    $^X, map("-I$_", @INC), '-MPrint::Indented', 't/data/a.pl'
], \my $in, \my $out, \my $err;

is $out, <<OUT, 'stdout';
foo
    bar
OUT

is $err, <<ERR, 'stderr';
    abc at t/data/a.pl line 8.
ERR

done_testing;
