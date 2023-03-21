#Create a simulator object

set ns [new Simulator]

#Define different colors for data flows

$ns color 1 Blue

$ns color 2 Red

#Open the nam trace file

set nf [open out.nam w]

$ns namtrace-all $nf

#Define a 'finish' procedure

proc finish {} {

global ns nf

$ns flush-trace

#Close the trace file

close $nf

#Execute nam on the trace file

exec nam out.nam &

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

#Monitor the queue for the link between node 2 and node 3

$ns duplex-link-op $n1 $n2 queuePos 0.5

#Create a UDP agent and attach it to node n0

set udp0 [new Agent/UDP]

$udp0 set class_ 1

$ns attach-agent $n1 $udp0

# Create a CBR traffic source and attach it to udp0

set cbr0 [new Application/Traffic/CBR]

$cbr0 set packetSize_ 500

$cbr0 set interval_ 0.005

$cbr0 attach-agent $udp0

#Create a UDP agent and attach it to node n0

set udp1 [new Agent/UDP]

$udp1 set class_ 1

$ns attach-agent $n2 $udp1

# Create a CBR traffic source and attach it to udp0

set cbr1 [new Application/Traffic/CBR]

$cbr1 set packetSize_ 500

$cbr1 set interval_ 0.005

$cbr1 attach-agent $udp1

# #Create a UDP agent and attach it to node n0

# set udp2 [new Agent/UDP]

# $udp2 set class_ 1

# $ns attach-agent $n3 $udp2

# # Create a CBR traffic source and attach it to udp0

# set cbr2 [new Application/Traffic/CBR]

# $cbr2 set packetSize_ 500

# $cbr2 set interval_ 0.005

# $cbr2 attach-agent $udp2

# #Create a UDP agent and attach it to node n0

# set udp3 [new Agent/UDP]

# $udp3 set class_ 1

# $ns attach-agent $n5 $udp3

# # Create a CBR traffic source and attach it to udp0

# set cbr3 [new Application/Traffic/CBR]

# $cbr3 set packetSize_ 500

# $cbr3 set interval_ 0.005

# $cbr3 attach-agent $udp3

# #Create a Null agent (a traffic sink) and attach it to node n3

set null0 [new Agent/Null]

$ns attach-agent $n4 $null0

#Connect the traffic sources with the traffic sink

$ns connect $udp0 $null0

$ns connect $udp1 $null0

#Schedule events for the CBR agents

$ns at 0.5 "$cbr0 start"

$ns at 1.0 "$cbr1 start"

# $ns at 1.5 "$cbr2 start"

# $ns at 2.0 "$cbr3 start"

# $ns at 3.0 "$cbr3 stop"

# $ns at 3.5 "$cbr2 stop"

$ns at 4.0 "$cbr1 stop"

$ns at 4.5 "$cbr0 stop"

#Call the finish procedure after 5 seconds of simulation time

$ns at 5.0 "finish"

#Run the simulation

$ns run

