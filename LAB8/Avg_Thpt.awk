#!/usr/bin/awk -f

BEGIN {
    # Set default values for variables
    tcp_byte_count = 0
    udp_byte_count = 0
    total_start_time = 0
    total_end_time = 0
}

# Process each packet in the trace file
{
    # Check if the packet is TCP or UDP
    if ($5 == "tcp") 
    {
        tcp_byte_count += $6

        if (tcp_start_time == 0 || $2 < tcp_start_time) 
        {
            tcp_start_time = $2
        }
        if ($2 > tcp_end_time) 
        {
            tcp_end_time = $2
        }
    } 
    else if ($5 == "cbr") 
    {
        udp_byte_count += $6

        if (udp_start_time == 0 || $2 < udp_start_time) 
        {
            udp_start_time = $2
        }
        if ($2 > udp_end_time) 
        {
            udp_end_time = $2
        }
    }

    if (total_start_time == 0 || $2 < total_start_time) 
    {
        total_start_time = $2
    }
    if ($2 > total_end_time) 
    {
        total_end_time = $2
    }
}

# Print final throughput if needed
END {
    if (tcp_byte_count > 0 || udp_byte_count > 0) 
    {    
        total_time = total_end_time - total_start_time
        tcp_time = tcp_end_time - tcp_start_time
        udp_time = udp_end_time - udp_start_time

        BC = tcp_byte_count + udp_byte_count
        
        avg_throughput = BC * 8 / total_time / 1000000
        tcp_throughput = tcp_byte_count * 8 / tcp_time / 1000000
        udp_throughput = udp_byte_count * 8 / udp_time / 1000000

        printf("Avg throughput: %.2f Mbps\n", avg_throughput)
        printf("Start time: %f s\n", total_start_time)
        printf("End time: %f s\n", total_end_time)
        printf("Total time: %f s\n", total_time)

        printf("\nTCP throughput: %.2f Mbps\n", tcp_throughput)
        printf("Start time: %f s\n", tcp_start_time)
        printf("End time: %f s\n", tcp_end_time)
        printf("Total time: %f s\n", tcp_time)

        printf("\nUDP throughput: %.2f Mbps\n", udp_throughput)
        printf("Start time: %f s\n", udp_start_time)
        printf("End time: %f s\n", udp_end_time)
        printf("Total time: %f s\n", udp_time)
    }
}
