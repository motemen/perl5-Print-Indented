requires 'perl', '5.008001';

requires 'Tie::StdHandle';
requires 'Scalar::Util';
requires 'Path::Tiny';
requires 'Symbol';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'IPC::Run';
};
