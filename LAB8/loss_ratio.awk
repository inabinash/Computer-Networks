BEGIN {
	send=0;
	received=0;
	dropped=0;
}

{
# Trace line format: normal
	event = $1;
	time = $2;
	from_node = $3;
	to_node = $4;
	pkt_type = $5;
	pkt_size = $6;
	flgs = $7;
	f_id = $8;
	src_addr = $9;
	dest_addr = $10;
	seq_no = $11;
	pkt_id = $12;
#packet delivery ratio
	if (event == "+" && pkt_type != "ack")
	{
		fro = int(from_node);
		src = int(src_addr);
		if (fro == src)
		{
			send++
		}
	}

	if (event == "r" && pkt_type != "ack") 
	{
		to = int(to_node);
		dst = int(dest_addr);
		if (to == dst)
		{
			received++
		}
	}

	if (event == "d")
	{
		dropped++;
	}
}
  
END{ 
	print "\nGeneratedPackets = " send;
	print "ReceivedPackets = " received;
	print "Total Dropped Packets = " dropped;
	print ("\nPacket Delivery Ratio = ", (received/send)*100" %");
	print ("Packet Loss Ratio = ", (dropped/send)*100" %");
}
