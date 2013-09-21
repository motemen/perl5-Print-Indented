use strict;
use warnings;

print "foo\n";

{
    print "bar\n";
    warn "abc";
}
