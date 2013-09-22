package Print::Indented::Handle;
use strict;
use warnings;
use Tie::Handle;
use parent -norequire => 'Tie::StdHandle';
use Scalar::Util qw(refaddr);
use Path::Tiny;
use Symbol;

our %Fh;

sub new {
    my ($class, $target) = @_;

    my $symbol = Symbol::gensym();
    my $self = tie *$symbol, $class;

    open my $original_fh, '>&', $target or die $!;
    $self->original_fh($original_fh);

    *$target = $symbol;

    return $self;
}

sub original_fh {
    my ($self, $fh) = @_;
    if (defined $fh) {
        $Fh{ refaddr $self } = $fh;
    }
    return $Fh{ refaddr $self };
}

sub PRINT {
    my ($self, @args) = @_;
    my (undef, $file, $nr) = caller;
    my $line = (path($file)->lines)[$nr-1];
    my ($indent) = $line =~ /^(\s*)/;
    foreach (grep length, split m<(.*$/?)>, join('', @args)) {
        print { $self->original_fh } "$indent$_";
    }
}

sub PRINTF {
    my ($self, $format, @args) = @_;
    @_ = ( $self, sprintf $format, @args );
    goto \&PRINT;
}

1;
