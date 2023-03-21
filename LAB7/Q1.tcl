#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows
$ns color 1 Blue


#Define the nam trace file 
set nf [open q1.nam w]
$ns namtrace-all $nf

#Define 'finish' procedure 
proc finish {} {
    global ns nf
    $ns flush-trace

    #Close trace file 
    close $nf

    #Execute nam on the trace file
    exec nam q1.nam &
    exit 0
}

#Create six nodes 
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]

#Create links between the nodes

$ns duplex-link $n1 $n2 100Mb 2ms DropTail
$ns duplex-link $n2 $n3 100Mb 2ms DropTail
$ns duplex-link $n3 $n4 100Mb 2ms DropTail
$ns duplex-link $n4 $n5 100Mb 2ms DropTail
$ns duplex-link $n5 $n6 100Mb 2ms DropTail
$ns duplex-link $n6 $n1 100Mb 2ms DropTail

#Give node positions (for NAM)

$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right
$ns duplex-link-op $n3 $n4 orient right-down
$ns duplex-link-op $n4 $n5 orient left-down
$ns duplex-link-op $n5 $n6 orient left
$ns duplex-link-op $n6 $n1 orient left-up


#Set up a TCP Connections 

set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n1 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n4 $sink
$ns connect $tcp $sink
$tcp set fid_ 1

#Set up a FTP over TCP Connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

#Schedule events for FTP agent
$ns at 0.0 "$ftp start"
$ns at 95.0 "$ftp stop"

#Call the finish procedure 
$ns at 100.0 "finish"
#Run simulation

$ns run


