# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

use Test::Simple tests=> 13;

use Tie::Hash::Regex;

ok(1);

my %hash : Regex;

$hash{key} = 'value';
$hash{key2} = 'another value';
$hash{stuff} = 'something else';

my $x = 'f';

ok($hash{key} eq 'value');
ok($hash{'^s'} eq 'something else');
ok($hash{qr'^s'} eq 'something else');
ok(not defined $hash{blah});
ok($hash{$x} eq 'something else');

my @vals = tied(%hash)->FETCH('k');
ok(@vals == 2);
delete $hash{stuff};
ok(keys %hash == 2);

ok(exists $hash{key});
ok(exists $hash{k});
ok(exists $hash{qr'^k'});

delete $hash{2};
my @k = keys %hash;
ok(@k == 1);
delete $hash{qr/^k/};
ok(not keys %hash);

