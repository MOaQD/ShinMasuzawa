package ShinMasuzawa::DeterminePreRank;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

sub new {
    my ($class,%opt) = @_;
    my $self = bless {
        %opt,
    },$class;
    $self;
}

sub detarmine {
    my %hash_kakutokunum = @_;
    $counter = 0;
    ### �l�������������ɒc�̂𐮗�
    $log->info("$proc","���� $rank �ʂ̌���");
    foreach my $name ( sort { $hash_kakutokunum{$b} <=> $hash_kakutokunum{$a} } keys %hash_kakutokunum ){
        ### ��Ԋl�����������c�̂��u���̑��ʁv�ɐݒ�
        ### �擪�ɂ���c�͖̂������Łu���̑��ʁv�Ƃ���
        if ( $counter == 0 ){
            $kari1st->{$name} = $hash_kakutokunum{$name};
            ### �ŏ��Ɂu���̑��ʁv�ƂȂ����c�̖���ϐ��Ɋi�[
            $name_1st = $name;
        ### �l�������Ő��񎞂̓�Ԗڈȍ~�̒c�̂ɂ��Ă̏���
        } else{
            ### �u���̑��ʁv�Ɠ����l�����̏ꍇ�́A�u���̑��ʁv�ɒǉ�
            if ( $kari1st->{$name_1st} == $hash_kakutokunum{$name} ){
                $kari1st->{$name} = $hash_kakutokunum{$name};
            ### �u���̑��ʁv���l���������Ȃ��A���u���̑��ʁv��������̏ꍇ�́u���̑��ʁv�ɐݒ�
            } elsif ( ( $kari1st->{$name_1st} > $hash_kakutokunum{$name} ) && ( !defined($kari2st) ) ){
                $kari2st->{$name} = $hash_kakutokunum{$name};
                ### �ŏ��Ɂu���̑��ʁv�ƂȂ����c�̖���ϐ��Ɋi�[
                $name_2st = $name;
            ### �u���̑��ʁv����ł����肵�Ă���ꍇ�̏���
            } elsif ( defined($kari2st) ){
                ### �u���̑��ʁv���l���������Ȃ��A���u���̑��ʁv�Ɗl�������������ꍇ�́u���̑��ʁv�ɒǉ�
                if ( ( $kari1st->{$name_1st} > $hash_kakutokunum{$name} ) &&  ( $kari2st->{$name_2st} == $hash_kakutokunum{$name} ) ){
                    $kari2st->{$name} = $hash_kakutokunum{$name};
                ### �u���̑��ʁv���l���������Ȃ��A���u���̑�O�ʁv��������̏ꍇ�́u���̑�O�ʁv�ɐݒ�
                } elsif ( ( $kari2st->{$name_2st} > $hash_kakutokunum{$name} ) && ( !defined($kari3st) ) ){
                    $kari3st->{$name} = $hash_kakutokunum{$name};
                    ### �ŏ��Ɂu���̑�O�ʁv�ƂȂ����c�̖���ϐ��Ɋi�[
                    $name_3st = $name;
                ### �u���̑�O�ʁv����ł����肵�Ă���ꍇ�̏���
                } elsif ( defined($kari3st) ){
                    ### �u���̑��ʁv���l���������Ȃ��A���u���̑�O�ʁv�Ɗl�������������ꍇ�́u���̑�O�ʁv�ɒǉ�
                    if ( ( $kari2st->{$name_2st} > $hash_kakutokunum{$name} ) &&  ( $kari3st->{$name_3st} == $hash_kakutokunum{$name} ) ){
                        $kari3st->{$name} = $hash_kakutokunum{$name};
                    }
                }
            }
        }
        $counter++;
    }
    return ($kari1st, $kari2st, $kari3st);
}

1;
__END__

=encoding utf-8

=head1 NAME

ShinMasuzawa::DeterminePreRank - It's new $module

=head1 SYNOPSIS

    use ShinMasuzawa::DeterminePreRank;

=head1 DESCRIPTION

ShinMasuzawa::DeterminePreRank is ...

=head1 LICENSE

Copyright (C) Keiji Kawabata.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Keiji Kawabata E<lt>kawabata.keiji@toshiba-sol.co.jpE<gt>

=cut

