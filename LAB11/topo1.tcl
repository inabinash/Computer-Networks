#create a new Simulator
set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red
$ns color 3 Green
$ns color 4 Black

#create trace file
set tf [open topo1.tr w]
set nf [open q.nam w]

$ns trace-all $tf
$ns namtrace-all $nf

#create nodes
for {set i 0} {$i < 10} {incr i} {
    set n[expr $i] [$ns node]
}

#create links
$ns duplex-link $n0 $n4 100Mb 25ms DropTail
$ns duplex-link $n1 $n4 100Mb 25ms DropTail
$ns duplex-link $n2 $n4 100Mb 25ms DropTail
$ns duplex-link $n3 $n4 100Mb 25ms DropTail

$ns duplex-link $n5 $n6 100Mb 25ms DropTail
$ns duplex-link $n5 $n7 100Mb 25ms DropTail
$ns duplex-link $n5 $n8 100Mb 25ms DropTail
$ns duplex-link $n5 $n9 100Mb 25ms DropTail

$ns duplex-link $n4 $n5 0.5Mb 100ms DropTail


#create agents

set tcp0 [new Agent/TCP]
$tcp0 set fid_ 1
$ns attach-agent $n0 $tcp0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n6 $sink0
$ns connect $tcp0 $sink0

set tcp1 [new Agent/TCP]
$tcp1 set fid_ 2
set ftp1 [new Application/FTP]
$ns attach-agent $n1 $tcp1
$ftp1 attach-agent $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n7 $sink1
$ns connect $tcp1 $sink1


set udp0 [new Agent/UDP]
$udp0 set fid_ 3

set cbr0 [ new Application/Traffic/CBR]
$cbr0 set packetSize_ 1000
$cbr0 attach-agent $udp0
$ns attach-agent $n3 $udp0
set null0 [new Agent/Null]
$ns attach-agent $n8 $null0
$ns connect $udp0 $null0

set udp1 [new Agent/UDP]
$udp1 set fid_ 4
$ns attach-agent $n3 $udp1
set cbr1 [ new Application/Traffic/CBR]
$cbr1 set packetSize_ 1000
$cbr1 attach-agent $udp1
set null1 [new Agent/Null]
$ns attach-agent $n9 $null1
$ns connect $udp1 $null1

#start the simulation
$ns at 0.0 "$ftp0 start"
$ns at 0.1 "$ftp1 start"
$ns at 0.2 "$cbr0 start"
$ns at 0.3 "$cbr1 start"

$ns at 54.0 "$ftp0 stop"
$ns at 55.0 "$ftp1 stop"
$ns at 56.0 "$cbr0 stop"
$ns at 57.0 "$cbr1 stop"

$ns at 60 "finish"

proc finish {} {
    global ns nf tf
    $ns flush-trace
    close $nf
    close $tf
    exec nam q.nam &
    exit 0

}


$ns run









