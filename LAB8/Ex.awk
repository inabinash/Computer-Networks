BEGIN{
	send=0;
	received=0;
	dropped=0;
	Bytes_Sent=0;
	Bytes_Received=0;
	StartTime=99.0;
	EndTime=0.0
}

{
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

	if (time<StartTime)
	{
		StartTime=time;
	}
	if (time>EndTime)
	{
		EndTime=time;
	}

	if (event == "+" && pkt_type != "ack")
	{
		fro = int(from_node);
		src = int(src_addr);
		if (fro == src_addr)
		{
			send++;
			Bytes_Sent += pkt_size;
			Sendtime[pkt_id] = time;
		}
	}

	if (event == "r" && pkt_type != "ack")
	{
		to = int(to_node);
		dst = int(dest_addr);
		if (to == dst)
		{
			received++;
			Bytes_Received += pkt_size;
			Receivedtime[pkt_id] = time;
			Delay[pkt_id] = Receivedtime[pkt_id] - Sendtime[pkt_id];
			Total_delay += Delay[pkt_id];
			node_thr[dst] += pkt_size;
		}
	}

	if (event == "d")
	{
		dropped++;
	}
}

END{
	printf("\nSent Packets = %d", send);
	printf("\nReceived Packets = %d", received);
	printf("\nDropped Packets = %d", dropped);
	printf("\nPacket Delivery Ratio = %f", (received/send)*100);
	printf("\nPacket Loss Ratio = %f", (dropped/send)*100);
	printf("\nSent = %0.2f KB", Bytes_Sent/1000);
	printf("\nReceived = %0.2f KB", Bytes_Received/1000);
	printf("\nStart = %0.2f s", StartTime);
	printf("\nEnd = %0.2f s", EndTime);
	printf("\nThroughtput = %0.2f Kbps", (Bytes_Received/(EndTime-StartTime))*(8/1000000));
	for (i=0; i<12; i++)
	{
		if (node_thr[i] > 0)
		{
			Th = (node_thr[i]/(EndTime-StartTime))*(8/1000);
			sum += Th;
			Sq_sum += (Th*Th);
			cnt++;
		}
	}
	JI = ((sum*sum)/(cnt*Sq_sum));
	printf("\nJain Index = %0.2f", JI);
	printf("\nDelay = %0.2f s", Total_delay/received);
}