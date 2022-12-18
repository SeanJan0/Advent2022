# part 1

sub extract_coords {
    $line = $_[0];
    @split = split(" ", $line);
    $x_1 = parse_num(@split[2]);
    $y_1 = parse_num(@split[3]);
    $x_2 = parse_num(@split[8]);
    $y_2 = parse_num(@split[9]);
    return ($x_1, $y_1, $x_2, $y_2);
}

sub parse_num {
    $num = $_[0];
    $num = substr($num, 2);
    return int($num);
}

sub distance {
    $x_1 = $_[0];
    $y_1 = $_[1];
    $x_2 = $_[2];
    $y_2 = $_[3];
    return abs($x_1 - $x_2) + abs($y_1 - $y_2);
}

sub get_range {
    $x = $_[0];
    $y = $_[1];
    $dist = $_[2];
    $y_target = $_[3];
    if (abs($y-$y_target) <= $dist) {
        $displacement = $dist - abs($y-$y_target);
        $x_min = $x - $displacement;
        $x_max = $x + $displacement;
        return ($x_min..$x_max);
    }
    return ();
}

$f = "day15/day15.txt";
open(FH, "<", $f);
@lines = ();
while (<FH>) {
    push(@lines, $_);
}
close(FH);

@x_removes = ();
$y_target = 2000000;
%invalid = ();

for $line (@lines) {
    ($x_1, $y_1, $x_2, $y_2) = extract_coords($line);
    $dist = distance($x_1, $y_1, $x_2, $y_2);
    @range = get_range($x_1, $y_1, $dist, $y_target);
    foreach $x (@range) {
        $invalid{$x} = 1;
    }
    if ($y_2 == $y_target) {
        push(@x_removes, $x_2);
    }
}

for $x (@x_removes) {
    delete $invalid{$x};
}

$num_invalid = scalar(keys %invalid);
print "$num_invalid\n";

# part 2

sub part2 {
    for $i (0..$#lines) {
        $max = $_[0];
        ($x_1, $y_1, $x_2, $y_2) = extract_coords($lines[$i]);
        $dist_1 = distance($x_1, $y_1, $x_2, $y_2);
        $a_1 = -$x_1 + $y_1 + $dist_1 + 1;
        $a_2 = -$x_1 + $y_1 - $dist_1 - 1;
        $a_3 = $x_1 + $y_1 + $dist_1 + 1;
        $a_4 = $x_1 + $y_1 - $dist_1 - 1;
        for $j ($i+1..$#lines) {
            ($x_3, $y_3, $x_4, $y_4) = extract_coords($lines[$j]);
            $dist_2 = distance($x_3, $y_3, $x_4, $y_4);
            $b_1 = -$x_3 + $y_3 + $dist_2 + 1;
            $b_2 = -$x_3 + $y_3 - $dist_2 - 1;
            $b_3 = $x_3 + $y_3 + $dist_2 + 1;
            $b_4 = $x_3 + $y_3 - $dist_2 - 1;
            if (($a_1 + $b_3) % 2 == 0 and is_valid(calc_inter($a_1,$b_3))) {
                ($x_ans, $y_ans) = calc_inter($a_1,$b_3);
                if (0 < $x_ans < $max and 0 < $y_ans < $max) {
                    return ($x_ans, $y_ans);
                }
            }
            if (($a_1 + $b_4) % 2 == 0 and is_valid(calc_inter($a_1,$b_4))) {
                ($x_ans, $y_ans) = calc_inter($a_1,$b_4);
                if (0 < $x_ans < $max and 0 < $y_ans < $max) {
                    return ($x_ans, $y_ans);
                }
            }
            if (($a_2 + $b_3) % 2 == 0 and is_valid(calc_inter($a_2,$b_3))) {
                ($x_ans, $y_ans) = calc_inter($a_2,$b_3);
                if (0 < $x_ans < $max and 0 < $y_ans < $max) {
                    return ($x_ans, $y_ans);
                }
            }
            if (($a_2 + $b_4) % 2 == 0 and is_valid(calc_inter($a_2,$b_4))) {
                ($x_ans, $y_ans) = calc_inter($a_2,$b_4);
                if (0 < $x_ans < $max and 0 < $y_ans < $max) {
                    return ($x_ans, $y_ans);
                }
            }
        }
    }
    return ();
}

sub is_valid {
    $x = $_[0];
    $y = $_[1];
    for $line (@lines) {
        ($x_1, $y_1, $x_2, $y_2) = extract_coords($line);
        $dist = distance($x_1, $y_1, $x_2, $y_2);
        $dist_check = distance($x_1, $y_1, $x, $y);
        if ($dist_check <= $dist) {
            return 0;
        }
    }
    return 1;
}

sub calc_inter {
    $a = $_[0];
    $b = $_[1];
    return (($b - $a) / 2, ($b + $a) / 2);
}

($x, $y) = part2(4000000);
$p2_ans = $x * 4000000 + $y;
print $p2_ans

