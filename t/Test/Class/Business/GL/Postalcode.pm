package Test::Class::Business::GL::Postalcode;

use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use Tree::Simple;
use Test::Exception;
use Env qw($TEST_VERBOSE);

sub startup : Test(startup => 1) {
    use_ok( 'Business::GL::Postalcode', qw(get_all_postalcodes get_all_data validate_postalcode validate));
};

sub test_get_all_postalcodes : Test(2) {
    ok(my $postalcodes_ref = get_all_postalcodes(), 'calling get all postalcodes');
    is(scalar(@{$postalcodes_ref}), 33), 'asserting number of postalcodes';
}

sub test_get_all_data : Test(2) {
    ok(my $postalcodes_ref = get_all_data(), 'calling get_all_data');

    is(scalar(@{$postalcodes_ref}), 33, 'asserting number of postalcodes');
}

sub test_validate_postalcode : Test(2) {
    my $self = shift;

    my @invalids = qw();
    my @valids = qw();

    foreach (0 .. 9999) {
        my $number = sprintf '%04d', $_;
        if (not validate_postalcode($number)) {
            push @invalids, $number;
        } else {
            push @valids, $number;
        }
    }

    is(scalar @invalids, 9967, 'asserting number of invalids for validate_postalcode');
    is(scalar @valids, 33, 'asserting number of valids for validate_postalcode');
}

sub test_validate : Test(2) {
    my $self = shift;

    my @invalids = qw();
    my @valids = qw();

    foreach (0 .. 9999) {
        my $number = sprintf '%04d', $_;
        if (not validate($number)) {
            push @invalids, $number;
        } else {
            push @valids, $number;
        }
    }

    is(scalar @invalids, 9967, 'asserting number of invalids for validate');
    is(scalar @valids, 33, 'asserting number of valids for validate');
}

1;