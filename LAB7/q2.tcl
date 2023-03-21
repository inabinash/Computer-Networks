set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red
$ns color 3 Darkgreen
$ns color 4 Orange
$ns color 5 Darkviolet
$ns color 6 Brown

set nf [open Ex.nam w]
$ns namtrace-all $nf

set tf [open Ex.tr w]
$ns trace-all $tf

proc finish {} {
	global ns nf tf
	$ns flush-trace
	close $nf
	close $tf
	exec nam Ex.nam &
	exec awk -f Ex.awk Ex.tr & 
	#exec awk -f Thrpt.awk Ex.tr > Th.tr &
	exit 0
}


set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]

$ns at 0.0 "$n0 color blue"
$ns at 0.0 "$n1 color red"
$ns at 0.0 "$n2 color darkgreen"
$ns at 0.0 "$n3 color orange"
$ns at 0.0 "$n4 color darkviolet"
$ns at 0.0 "$n5 color brown"
$ns at 0.0 "$n6 color blue"
$ns at 0.0 "$n7 color red"
$ns at 0.0 "$n8 color darkgreen"
$ns at 0.0 "$n9 color orange"
$ns at 0.0 "$n10 color darkviolet"
$ns at 0.0 "$n11 color brown"

$ns at 0.0 "$n0 label \"Node #1(SENDER)\""
$ns at 0.0 "$n1 label \"Node #2(SENDER)\""
$ns at 0.0 "$n2 label \"Node #3(SENDER)\""
$ns at 0.0 "$n3 label \"Node #4(SENDER)\""
$ns at 0.0 "$n4 label \"Node #5(SENDER)\""
$ns at 0.0 "$n5 label \"Node #6(SENDER)\""
$ns at 0.0 "$n6 label \"Node #1(RECEIVER)\""
$ns at 0.0 "$n7 label \"Node #2(RECEIVER)\""
$ns at 0.0 "$n8 label \"Node #3(RECEIVER)\""
$ns at 0.0 "$n9 label \"Node #4(RECEIVER)\""
$ns at 0.0 "$n10 label \"Node #5(RECEIVER)\""
$ns at 0.0 "$n11 label \"Node #6(RECEIVER)\""

$ns duplex-link $n0 $n12 300Mb 20ms DropTail
$ns duplex-link-op $n0 $n12 orient 285deg

$ns duplex-link $n1 $n12 300Mb 20ms DropTail
$ns duplex-link-op $n1 $n12 orient 315deg

$ns duplex-link $n2 $n12 300Mb 20ms DropTail
$ns duplex-link-op $n2 $n12 orient 345deg

$ns duplex-link $n3 $n12 300Mb 20ms DropTail
$ns duplex-link-op $n3 $n12 orient 15deg

$ns duplex-link $n4 $n12 300Mb 20ms DropTail
$ns duplex-link-op $n4 $n12 orient 45deg

$ns duplex-link $n5 $n12 300Mb 20ms DropTail
$ns duplex-link-op $n5 $n12 orient 75deg

$ns duplex-link $n12 $n13 1Mb 10ms DropTail
$ns duplex-link-op $n12 $n13 orient right

$ns duplex-link $n13 $n6 300Mb 20ms DropTail
$ns duplex-link-op $n13 $n6 orient 75deg

$ns duplex-link $n13 $n7 300Mb 20ms DropTail
$ns duplex-link-op $n13 $n7 orient 45deg

$ns duplex-link $n13 $n8 300Mb 20ms DropTail
$ns duplex-link-op $n13 $n8 orient 15deg

$ns duplex-link $n13 $n9 300Mb 20ms DropTail
$ns duplex-link-op $n13 $n9 orient 345deg

$ns duplex-link $n13 $n10 300Mb 20ms DropTail
$ns duplex-link-op $n13 $n10 orient 315deg

$ns duplex-link $n13 $n11 300Mb 20ms DropTail
$ns duplex-link-op $n13 $n11 orient 285deg

$ns duplex-link-op $n12 $n13 queuePos 0.5

$ns queue-limit $n12 $n13 4

set tcp1 [new Agent/TCP/Reno]
$ns attach-agent $n0 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n6 $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 1
$tcp1 set window_ 8
$tcp1 set ssthresh_ 3
$tcp1 set windowInit_ 1



set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set tcp2 [new Agent/TCP]
$ns attach-agent $n1 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n7 $sink2
$ns connect $tcp2 $sink2
$tcp2 set fid_ 2
$tcp2 set window_ 8
$tcp2 set ssthresh_ 3
$tcp2 set windowInit_ 1

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

set tcp3 [new Agent/TCP]
$ns attach-agent $n2 $tcp3
set sink3 [new Agent/TCPSink]
$ns attach-agent $n8 $sink3
$ns connect $tcp3 $sink3
$tcp3 set fid_ 3
$tcp3 set window_ 8
$tcp3 set ssthresh_ 3
$tcp3 set windowInit_ 1


set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3

set tcp4 [new Agent/TCP]
$ns attach-agent $n3 $tcp4
set sink4 [new Agent/TCPSink]
$ns attach-agent $n9 $sink4
$ns connect $tcp4 $sink4
$tcp4 set fid_ 4
$tcp4 set window_ 8
$tcp4 set ssthresh_ 3
$tcp4 set windowInit_ 1

set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4

set udp5 [new Agent/UDP]
$ns attach-agent $n4 $udp5
set null5 [new Agent/Null]
$ns attach-agent $n10 $null5
$ns connect $udp5 $null5
$udp5 set fid_ 5

set cbr5 [new Application/Traffic/CBR]
$cbr5 attach-agent $udp5
$cbr5 set packet_size_ 1000

set udp6 [new Agent/UDP]
$ns attach-agent $n5 $udp6
set null6 [new Agent/Null]
$ns attach-agent $n11 $null6
$ns connect $udp6 $null6
$udp6 set fid_ 6

set cbr6 [new Application/Traffic/CBR]
$cbr6 attach-agent $udp6
$cbr6 set packet_size_ 1000


set f_cwnd [open cwnd.tr w]

proc Record {} {
	global f_cwnd tcp1 tcp2 tcp3 tcp4 ns
	set intval 0.1
	set now [$ns now]
	set cwnd1 [$tcp1 set cwnd_]
    set cwnd2 [$tcp2 set cwnd_]
	set cwnd3 [$tcp3 set cwnd_]
	set cwnd4 [$tcp4 set cwnd_]

	

	puts $f_cwnd "$now $cwnd1  $cwnd2  $cwnd3 $cwnd4"
	$ns at [expr $now + $intval] "Record"
}

$ns at 0.1 "Record"
$ns at 0.0 "$ftp1 start"
$ns at 0.0 "$ftp2 start"
$ns at 0.0 "$ftp3 start"
$ns at 0.0 "$ftp4 start"
$ns at 0.0 "$cbr5 start"
$ns at 0.0 "$cbr6 start"

$ns at 10.0 "finish"

$ns run