use Test::More tests=> 12;

BEGIN { use_ok 'Tie::Hash::Regex' };

my %hash : Regex;

$hash{ key1  } = "one";
$hash{ key2  } = "two";
$hash{ key11 } = "eleven";

# normal behaviour, without regex

($one, $two) = @hash{ 'key1', 'key2' };

ok( $one eq $hash{ key1  } );
ok( $two eq $hash{ key2  } );

%ones = %hash{ 'key1', 'key11' };

ok( $ones{ key1  } eq $hash { key1  } );
ok( $ones{ key11 } eq $hash { key11 } );

undef $one;
undef $two;
undef %ones;

# since 5.20 we have slices.... making regex more fun

($one, $two) = @hash{ qr/^key\d$/ };

ok( $one eq $hash{ key1  } );
ok( $two eq $hash{ key2  } );

%ones = %hash{ qr/^key1+$/ };

ok( $ones{ key1  } eq $hash { key1  } );
ok( $ones{ key11 } eq $hash { key11 } );

@dels = delete @hash{ qr/^key\d$/ };
ok( $#dels == 1 );

@oops = delete @hash { 'key3', 'key2' };
ok( $#oops == 1 );
ok( $oops[0] eq undef );
