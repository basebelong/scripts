#!/usr/bin/env perl
#use strict;
#use warnings;

my $status;
open(my $fh, '<', '/sys/class/power_supply/BAT1/status');
{
    local $/;
    $status = <$fh>;
}

my $en_now;
open(my $fh, '<', '/sys/class/power_supply/BAT1/energy_now');
{
    local $/;
    $en_now = <$fh>;
}
close($fh);

my $pow_now;
open(my $fh, '<', '/sys/class/power_supply/BAT1/power_now');
{
    local $/;
    $pow_now = <$fh>;
}
close($fh);

my $percent;
open(my $fh, '<', '/sys/class/power_supply/BAT1/capacity');
{
    local $/;
    $percent = <$fh>;
}
close($fh);

my $h_left = $en_now / $pow_now;

my @split_h=split('\.', $h_left);

my $hours=@split_h[0];
my $minutes=@split_h[1]*60;
$minutes=substr($minutes, 0, 2);
chomp $percent;
chomp $status;

print("Battery: " . $percent . "\%\n" . $status . "\n" . "Time: " . $hours . ':' . $minutes . "\n");

