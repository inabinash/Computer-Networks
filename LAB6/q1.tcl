#Create a simulator object 
set ns [new Simulator]
 
#Define different colors for data flows
$ns color 1 Blue
$ns color 2 Red

#Open the nam trace file 
set nf [open q1.nam w]
$ns namtrace-all $nf
 
#Define a 'finish' procedure
proc finish {} {
 
    global ns nf
    $ns flush-trace
    
    #Close the trace file
    close $nf
    
    #Execute nam on the trace file
    exec nam q1.nam &
    
    exit 0
 
}
 
#Create four nodes
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
 
#Create links between the nodes
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n5 $n2 1Mb 10ms DropTail
$ns duplex-link $n3 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n4 1Mb 10ms DropTail

$ns duplex-link-op $n1 $n2 orient right-down
$ns duplex-link-op $n5 $n2 orient right
$ns duplex-link-op $n3 $n2 orient right-up
$ns duplex-link-op $n2 $n4 orient right

#Setup a TCP connection between nodes 1 and 4
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n1 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n4 $sink
$ns connect $tcp $sink
$tcp set fid_ 1

#Setup a FTP over TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

#Setup a TCP connection between nodes 3 and 4
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n3 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n4 $sink
$ns connect $tcp $sink
$tcp set fid_ 1

#Setup a FTP over TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

#Schedule events for FTP agent
$ns at 5.0 "$ftp start"
$ns at 45.0 "$ftp stop"

#Setup a UDP connection 
set udp [new Agent/UDP]
$ns attach-agent $n5 $udp

set null [new Agent/Null]
$ns attach-agent $n4 $null
$ns connect $udp $null
$udp set fid_ 2

#Setup a CBR over UDP connection
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR

#Schedule events for CBR agent
$ns at 5.0 "$cbr start"
$ns at 45.0 "$cbr stop"

#Call the finish procedure after 5 seconds of simulation time
$ns at 50.0 "finish"

#Run the simulation
$ns run