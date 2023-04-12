set terminal png
set output "RTT.png"
set xlabel "time"
set ylabel "RTT"

set grid
set style data lines
plot "topo1.txt"  with lines title "100Mbps" ,\
"topo2.txt" with lines title "10Mbps",\
"topo4.txt" with lines title "5Mbps",\
"topo3.txt" with lines title "1Mbps",\
"topo6.txt" with lines title "0.5Mbps",\
"topo5.txt" with lines title "0.1Mbps"





