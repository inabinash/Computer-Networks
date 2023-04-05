set terminal png
set output "Congestion.png"
set xlabel "time"
set ylabel "Congestion Window"
set autoscale 
set grid
set style data lines
plot "../Tcwnd.tr"  with lines title "Tahoe","../Rcwnd.tr" with lines title "Reno"
