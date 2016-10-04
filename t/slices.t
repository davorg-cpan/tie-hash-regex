use Test::More;

BEGIN { use_ok 'Tie::Hash::Regex' };

plan skip_all => 'Old Perl' if $] lt '5.020';

my %hash : Regex;

$hash{ key1  } = "one";
$hash{ key2  } = "two";
$hash{ key11 } = "eleven";

# normal behaviour, without regex

($one, $two) = @hash{ 'key1', 'key2' };

is( $one, $hash{ key1  }, 'Simple key check 1' );
is( $two, $hash{ key2  }, 'Simple key check 2' );

%ones = %hash{ 'key1', 'key11' };

is( $ones{ key1  }, $hash { key1  }, 'Simple key check 3' );
is( $ones{ key11 }, $hash { key11 }, 'Simple key check 4' );

undef $one;
undef $two;
undef %ones;

# since 5.20 we have slices.... making regex more fun

($one, $two) = @hash{ qr/^key\d$/ };

#TODO: {
#  local $TODO = q[This doesn't work];
#
#  is( $one, $hash{ key1  }, 'Slice test 1' );
#  is( $two, $hash{ key2  }, 'Slice test 2' );
#
#  %ones = %hash{ qr/^key1+$/ };
#
#  is( $ones{ key1  }, $hash { key1  }, 'Slice test 3' );
#  is( $ones{ key11 }, $hash { key11 }, 'Slice test 4' );
#
#  @dels = delete @hash{ qr/^key\d$/ };
#  is( $#dels, 1, 'Deletion test 1' );
#}

@oops = delete @hash { 'key3', 'key2' };
is( $#oops, 1, 'Deletion test 2' );

#TODO: {
#  local $TODO = q[This doesn't work];
#
#  ok( ! defined $oops[0], 'Deletion test 3' );
#}

done_testing();
