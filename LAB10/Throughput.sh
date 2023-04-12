set terminal png
set output "Throughput.png"
set xlabel "time"
set ylabel "Throughput"
set autoscale 
set grid
set style data lines
plot "D0.tr"  with lines title "D0 TCP","D1.tr" with lines title "D1 TCP"