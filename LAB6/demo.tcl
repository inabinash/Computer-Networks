set ns [ new Simulator ]
set n0 [$ns node]
set n1 [$ns node]

$ns color 1 Blue
set nf [ open out.nam  w ]
$ns namtrace-all $nf

set tf [open demo.tr w]
$ns trace-all $tf

proc finish {} {
    global ns nf tf
    $ns flush-trace
    close $nf
    close $tf
    exec nam out.nam &
    exit 0

}

$ns duplex-link $n0 $n1 1Mb 10ms DropTail

set udp [new Agent/UDP]
set cbr [ new Application/Traffic/CBR ]
$udp set fid_ 1
$cbr set packetSize_ 1000



$cbr attach-agent $udp
$ns attach-agent $n0 $udp

set null0 [new Agent/Null]
$ns attach-agent $n1 $null0

$ns connect $udp $null0


$ns at 0.1 "$cbr start"
$ns at 2 "$cbr stop"

$ns at 3 "finish"

$ns run

