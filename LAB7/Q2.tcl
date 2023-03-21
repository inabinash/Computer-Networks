set ns [new Simulator]

$ns color 1 Blue 
$ns color 1 Red

set nf [open q2.nam w]
$ns namtrace-all $nf

proc finsh {} {
    global ns nf
    $ns flush-trace 
    close $nf
    exec nam q2.nam &
    exit 0
}

for {set i 0} {$i < 14} {incr i} {
    set node($i) [$ns node]
}

for {set i 0} {$i < 6} {incr i} {
    $ns duplex-link $node($i) $node(6) 300Mb 20ms DropTail
    $ns duplex-link $node(8) $node([expr $i+8]) 300Mb 20ms DropTail

}

$ns duplex-link $node(6) $node(7) 500Mb 10ms DropTail

for {set i 0} {$i < 4} {incr i} {
    set tcp($i) [new Agent/TCP]
    $tcp($i) set class_ 2
    $ns attach-agent $node($i) $tcp($i)

    set sink($i) [new Agent/TCPSink]
    $ns attach-agent $node([expr $i+8]) $sink($i)
    $ns connect $tcp($i) $sink($i)
    $tcp($i) set fid_ 1

    set ftp($i) [new Application/FTP]
    $ftp($i) attach-agent $tcp($i)
    $ftp($i) set type_ FTP 
}

for {set i 0} {$i < 2} {incr i} {
    set udp($i) [new Agent/UDP]
    $ns attach-agent $node([expr $i+4]) $udp($i)

    set null($i) [new Agent/Null]
    $ns attach-agent $node([expr $i+12]) $null($i)
    $ns connect $udp($i) $null($i)
    $udp($i) set fid_ 2 

    set cbr($i) [new Application/Traffic/CBR]
    $cbr($i) attach-agent $udp($i)
    $cbr($i) set type_ CBR
}

#Schedule events for FTP and CBR
for {set i 0} {$i < 4} {incr i} {
    $ns at 1.0 "$ftp($i) start"
}
for {set i 0} {$i < 2} {incr i} {
    $ns at 15.0 "$cbr($i) start"
}

#Call for finish 
$ns at 100.0 "finish"

$ns run 