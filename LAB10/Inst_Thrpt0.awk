#!/usr/bin/awk -f

BEGIN {
    # Set default values for variables
    interval = 0.1  # Time interval in seconds
    time = 0.1
    tcp_byte_count = 0
    tcp_throughput = 0
}

# Process each packet in the trace file
{
    # Check if the packet is TCP or UDP
    if ($5 == "tcp") {
        tcp_byte_count += $6
    }

    # Update time and calculate throughput every "interval" seconds
    if ($2 >= time) 
    {
		tcp_throughput = tcp_byte_count * 8 / interval / 1000
        printf("%.2f %.2f\n", time, tcp_throughput)
        time += interval
        tcp_byte_count = 0
    }
}

# Print final throughput if needed
END {
   ; #if (tcp_byte_count > 0 || udp_byte_count > 0) {
     #   tcp_throughput = tcp_byte_count * 8 / interval / 1000000
      #  udp_throughput = udp_byte_count * 8 / interval / 1000000
       # printf("%.2f %.2f %.2f\n", time, tcp_byte_count, udp_byte_count)
    #}
}
