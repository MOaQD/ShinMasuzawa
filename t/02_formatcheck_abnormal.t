use strict;
use Test::More 0.98;
use Test::Exception;

use Log::Handler;

use ShinMasuzawa::FormatCheck;

my $proc = "Process-0";
my $proc_org = $proc;
my $logdir = "./logs";

# set for Log::Handler
my $log = Log::Handler->new();
$log->add(
    file => {
        filename => "$logdir/masuzawa.log",
        timeformat => "%Y%m%d %H:%M:%S %z",
        maxlevel => 7,
        minlevel => 0,
        message_layout => "%T %L %m",
    }
);
$log->add(
    file => {
        filename => "$logdir/masuzawa.log_error",
        timeformat => "%Y-%m-%d %H:%M:%S",
        maxlevel => 4,
        minlevel => 0,
        message_layout => "%T %L %m (%C)",
    }
);

### 出場団体の定義
my $dantai_five = ['A','B','C','D','E'];

### 出場団体数の定義
my $dantainum_five = scalar @$dantai_five;

### 順位表の定義
my $judge = {
    judge_1 => ['A','B','E','D','C'],
    judge_2 => ['C','E','B','D','A'],
    judge_3 => ['C','B','E','D','A'],
    judge_4 => ['E','B','C','D','A'],
    judge_5 => ['E','B','C','D','A'],
    judge_6 => ['B','E','C','D','A'],
    judge_7 => ['B','E','C','D','A'],
};

### 獲得数格納用変数の定義
my $kakutokunum;

### 審査員の数の取得
my $judgenum = keys(%$judge);

# set for ShinMasuzawa::FormatCheck
my $chk = ShinMasuzawa::FormatCheck->new(
        proc => $proc,
        proc_org => $proc_org,
        dantainum => $dantainum_five,  #出場団体数
        judge => $judge,            #順位表
        judgenum => $judgenum,      #審査員の数
        log => $log,
);

my $kahansu = $chk->check_JudgeNum;

### 正常系
is( $kahansu, '4', "kahansu is 4." );
ok( $chk->check_GroupNum, "GroupNum is all 5." );
is( $chk->check_GroupNum, '1', "GroupNum is all 5. again" );


$chk->{judge} = {
    judge_1 => ['A','B','E','D'],
    judge_2 => ['C','E','B','D','A'],
    judge_3 => ['C','B','E','D','A'],
    judge_4 => ['E','B','C','D','A'],
    judge_5 => ['E','B','C','D','A'],
    judge_6 => ['B','E','C','D','A'],
    judge_7 => ['B','E','C','D','A'],
};

dies_ok { $chk->check_GroupNum, } 'GroupNum of judge_1 is 4.';

$chk->{judge} = {
    judge_1 => ['A','B','E','D','C'],
    judge_2 => ['C','E','B','D'],
    judge_3 => ['C','B','E','D','A'],
    judge_4 => ['E','B','C','D','A'],
    judge_5 => ['E','B','C','D','A'],
    judge_6 => ['B','E','C','D','A'],
    judge_7 => ['B','E','C','D','A'],
};

dies_ok { $chk->check_GroupNum, } 'GroupNum of judge_2 is 4.';

$chk->{judge} = {
    judge_1 => ['A','B','E','D','C'],
    judge_2 => ['C','E','B','D','A'],
    judge_3 => ['C','B','E','D'],
    judge_4 => ['E','B','C','D','A'],
    judge_5 => ['E','B','C','D','A'],
    judge_6 => ['B','E','C','D','A'],
    judge_7 => ['B','E','C','D','A'],
};

dies_ok { $chk->check_GroupNum, } 'GroupNum of judge_3 is 4.';

$chk->{judge} = {
    judge_1 => ['A','B','E','D','C'],
    judge_2 => ['C','E','B','D','A'],
    judge_3 => ['C','B','E','D','A'],
    judge_4 => ['E','B','C','D'],
    judge_5 => ['E','B','C','D','A'],
    judge_6 => ['B','E','C','D','A'],
    judge_7 => ['B','E','C','D','A'],
};

dies_ok { $chk->check_GroupNum, } 'GroupNum of judge_4 is 4.';

$chk->{judge} = {
    judge_1 => ['A','B','E','D','C'],
    judge_2 => ['C','E','B','D','A'],
    judge_3 => ['C','B','E','D','A'],
    judge_4 => ['E','B','C','D','A'],
    judge_5 => ['E','B','C','D'],
    judge_6 => ['B','E','C','D','A'],
    judge_7 => ['B','E','C','D','A'],
};

dies_ok { $chk->check_GroupNum, } 'GroupNum of judge_5 is 4.';

done_testing;

