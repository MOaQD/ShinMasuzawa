package ShinMasuzawa::DetarmineTop;
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
    my ($self, $kari1st, $kari2st, $kari3st, $rank) = @_;

    my $TOP;
    my $SECOUND;
    ### �e�u���́��ʁv�̒c�̐���ϐ��ɑ��
    my $num_1st = keys(%$kari1st);
    my $num_2st = keys(%$kari2st);
    my $num_3st = keys(%$kari3st);
    ### �e�u���́��ʁv�̊l������ϐ��ɑ��
    my $kakutoku_1st = 0;
    my $kakutoku_2st = 0;
    my $kakutoku_3st = 0;
    if ( defined($kari1st) ) {
        foreach my $hash_value (keys %$kari1st){
            $kakutoku_1st += $kari1st->{$hash_value};
        }
    }
    if ( defined($kari2st) ) {
        foreach my $hash_value (keys %$kari2st){
            $kakutoku_2st += $kari2st->{$hash_value};
        }
    }
    if ( defined($kari3st) ) {
        foreach my $hash_value (keys %$kari3st){
            $kakutoku_3st += $kari3st->{$hash_value};
            last;
        }
    }
    
    ### �u���̑�1�ʁv�Ɓu���̑�2�ʁv�̊l�����̍��v��ϐ��ɑ��
    my $kakutoku_1_2 = $kakutoku_1st + $kakutoku_2st;
    
    ###���[��1�F�u���̑�1�ʁv��1�c�̂����ŁA���A���̊l�������R�����̔����𒴂����ꍇ�́A���̒c�̂�������1�ʂƂȂ�B
    if ( $num_1st == 1 && $kakutoku_1st > $kahansu ){
        foreach my $hash_value (keys %$kari1st){
            $TOP = $hash_value;
        }
        $log->info("$proc","���[��1�u�u���̑�1�ʁv��1�c�̂����ŁA���A���̊l�������R�����̔����𒴂����ꍇ�́A���̒c�̂�������1�ʂƂȂ�B�v���K�p����܂��B");
        $log->info("$proc","������ $rank �ʂ́A$TOP �ł��B");
    ###���[��2�F�u���̑�1�ʁv��2�c�̑��݂��A���A���҂̊l�����̍��v�������𒴂���ꍇ�ɂ́A����2�c�̂Ō��I���[���s���A������1�ʂ����肷��B
    } elsif ( $num_1st == 2 && $kakutoku_1st > $kahansu ){
        $log->info("$proc","���[��2�u�u���̑�1�ʁv��2�c�̑��݂��A���A���҂̊l�����̍��v�������𒴂���ꍇ�ɂ́A����2�c�̂Ō��I���[���s���A������1�ʂ����肷��B�v���K�p����܂��B");
        my @array_for_kessen = ();
        foreach my $hash_value (keys %$kari1st){
            push @array_for_kessen, $hash_value;
        }
        ### ���I���[�̎��s
        $TOP = &kessen(@array_for_kessen);
        $log->info("$proc","������ $rank �ʂ́A$TOP �ł��B");
    ###���[��3�F�u���̑�1�ʁv��3�c�̈ȏ㑶�݂��A���A�u���̑�1�ʁv�S���̊l�����̍��v�������𒴂���ꍇ�ɂ́A�����̒c�̂ŏ����|�C���g�I�����s���A������1�ʂ����肷��B
    } elsif ( $num_1st >= 2 && $kakutoku_1st > $kahansu ){
        $log->info("$proc","���[��3�u�u���̑�1�ʁv��3�c�̈ȏ㑶�݂��A���A�u���̑�1�ʁv�S���̊l�����̍��v�������𒴂���ꍇ�ɂ́A�����̒c�̂ŏ����|�C���g�I�����s���A������1�ʂ����肷��B�v���K�p����܂��B");
        ### �����|�C���g�I���̎��s
        $TOP = &kachipoint($kari1st);
    ###���[��4�F�u���̑�1�ʁv�̊l�����������𒴂����A�u���̑�1�ʁv�Ɓu���̑�2�ʁv�̊l�����̍��v�������𒴂����ꍇ
    } elsif ( $num_1st == 1 && $kakutoku_1st <= $kahansu && $kakutoku_1_2 > $kahansu ){
        $log->info("$proc","���[��4�u�u���̑�1�ʁv�̊l�����������𒴂����A�u���̑�1�ʁv�Ɓu���̑�2�ʁv�̊l�����̍��v�������𒴂����ꍇ�v���K�p����܂��B");
        ###�u���̑�2�ʁv����c�̂̏ꍇ�A�u���̑�1�ʁv�Ɓu���̑�2�ʁv�ɂ���Č��I���[���s���A������1�ʂ����肷��B
        if ( $num_2st == 1 ){
            $log->info("$proc","�u���̑�2�ʁv��1�c�̂Ȃ̂ŁA�u���̑�1�ʁv�Ɓu���̑�2�ʁv�ɂ���Č��I���[���s���A������1�ʂ����肵�܂��B");
            my @array_for_kessen = ();
            foreach my $hash_value (keys %$kari1st){
                push @array_for_kessen, $hash_value;
            }
            foreach my $hash_value (keys %$kari2st){
                push @array_for_kessen, $hash_value;
            }
            ### ���I���[�̎��s
            $TOP = &kessen(@array_for_kessen);
            $log->info("$proc","������ $rank �ʂ́A$TOP �ł��B");
        ###�u���̑�2�ʁv���������݂���ꍇ�ɂ́A�ŏ��Ɂu���̑�2�ʁv�̒c�̂ɂ����Č��I���[���͏����|�C���g�I�����s���A�u��1�ʌ��v��1�c�̂����I������B���ɁA�u���̑�1�ʁv�Ɓu��1�ʌ��v�ƂŌ��I���[���s���A������1�ʂ����肷��B
        } else {
            ###�u���̑�2�ʁv��2�c�̂̏ꍇ�͌��I���[���s���A�u��1�ʌ��v��I������B
            if ( $num_2st == 2 ){
                $log->info("$proc","�u���̑�2�ʁv��2�c�̂Ȃ̂ŁA�u���̑�2�ʁv���m�Ō��I���[���s���A�u��1�ʌ��v��I�����܂��B");
                my @array_for_kessen = ();
                foreach my $hash_value (keys %$kari2st){
                    push @array_for_kessen, $hash_value;
                }
                ### ���I���[�̎��s
                $SECOUND = &kessen(@array_for_kessen);
            ###�u���̑�2�ʁv��3�c�̈ȏ�̏ꍇ�͏����|�C���g�I�����s���A�u��1�ʌ��v��I������B
            } elsif ( $num_2st <= 3) {
                $log->info("$proc","�u���̑�2�ʁv��3�c�̈ȏ�Ȃ̂ŁA�u���̑�2�ʁv���m�ŏ����|�C���g�I�����s���A�u��1�ʌ��v��I�����܂��B");
                ### �����|�C���g�I���̎��s
                $SECOUND = &kachipoint($kari2st);
            }
            ###�u���̑�1�ʁv�Ɓu��1�ʌ��v�ƂŌ��I���[���s��
            my @array_for_kessen = ();
            foreach my $hash_value (keys %$kari1st){
                $log->info("$proc","�u���̑�1�ʁv�́A$hash_value �ł��B");
                push @array_for_kessen, $hash_value;
            }
            $log->info("$proc","�u��1�ʌ��v�́A$SECOUND �ł��B");
            push @array_for_kessen, $SECOUND;
            ### ���I���[�̎��s
            $TOP = &kessen(@array_for_kessen);
            $log->info("$proc","������ $rank �ʂ́A$TOP �ł��B");
        }
    }
    
    return $TOP;
}

1;
__END__

=encoding utf-8

=head1 NAME

ShinMasuzawa::DetarmineTop - It's new $module

=head1 SYNOPSIS

    use ShinMasuzawa::DetarmineTop;

=head1 DESCRIPTION

ShinMasuzawa::DetarmineTop is ...

=head1 LICENSE

Copyright (C) Keiji Kawabata.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Keiji Kawabata E<lt>kawabata.keiji@toshiba-sol.co.jpE<gt>

=cut

