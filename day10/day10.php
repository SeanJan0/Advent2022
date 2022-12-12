<?php
// part 1
$lines = file('day10/day10.txt', FILE_IGNORE_NEW_LINES);
$clockcycle = 0;
$regVal = 1;
$checkThresh = 20;
$signalSum = 0;

foreach ($lines as $line) {
    if ($line == "noop") {
        $clockcycle += 1;
    } else {
        $clockcycle += 1;
        if ($clockcycle == $checkThresh) {
            $signalSum += getSignal();
        }
        $clockcycle += 1;
        $regVal += explode(" ", $line)[1];
    }
    if ($clockcycle == $checkThresh) {
        $signalSum += getSignal();
    }
}

echo $signalSum;
echo "\n";

function getSignal() {
    global $regVal, $clockcycle, $checkThresh;
    $signal = $regVal * $clockcycle;
    $checkThresh += 40;
    return $signal;
}

// part 2

$clockcycle = 0;
$regVal = 1;
$screen = array_fill(0, 6, "");

foreach ($lines as $line) {
    if ($line == "noop") {
        draw();
        $clockcycle += 1;
    } else {
        draw();
        $clockcycle += 1;
        draw();
        $clockcycle += 1;
        $regVal += explode(" ", $line)[1];
    }
}

function draw() {
    global $clockcycle, $regVal, $screen;
    $row = intdiv($clockcycle, 40);
    $col = ($clockcycle) % 40;
    if (abs($col - $regVal) <= 1) {
        $screen[$row][$col] = "#";
    }
}

print_r($screen);
?>