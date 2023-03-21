#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows
$ns color 1 Red

#Open the nam trace file
set nf [open q2.nam w]
$ns namtrace-all $nf

#Define a 'finish' procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    
    #Close the trace file
    close $nf
    #Execute nam on the trace file
    exec nam q2.nam &
    exit 0
}

#Create seven nodes
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]

#Create links between the nodes
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n3 $n4 1Mb 10ms DropTail
$ns duplex-link $n4 $n5 1Mb 10ms DropTail
$ns duplex-link $n5 $n6 1Mb 10ms DropTail
$ns duplex-link $n6 $n7 1Mb 10ms DropTail
$ns duplex-link $n7 $n1 1Mb 10ms DropTail

$ns duplex-link-op $n1 $n2 orient right-down
$ns duplex-link-op $n2 $n3 orient down
$ns duplex-link-op $n3 $n4 orient down
$ns duplex-link-op $n4 $n5 orient left-down
$ns duplex-link-op $n5 $n6 orient left
$ns duplex-link-op $n6 $n7 orient left-up
$ns duplex-link-op $n7 $n1 orient right-up

#Setup a UDP connection 
set udp [new Agent/UDP]
$ns attach-agent $n1 $udp

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
$ns at 15.0 "$cbr stop"

#Call the finish procedure after 5 seconds of simulation time
$ns at 20.0 "finish"

#Run the simulation
$ns run