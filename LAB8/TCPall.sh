set terminal png
set output "Result.png"
set xlabel "time"
set ylabel "Congestion Window size"
set autoscale 
set grid
set style data lines
plot "../cwnd.tr" using 1:2 with lines title "TCP1",\
"../cwnd.tr" using 1:3 with lines title "TCP2",\
"../cwnd.tr" using 1:4 with lines title "TCP3",\
"../cwnd.tr" using 1:5 with lines title "TCP4"