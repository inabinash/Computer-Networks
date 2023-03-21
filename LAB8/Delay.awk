BEGIN{
	receiveNum = 0;
}

{
	event = $1
	time = $2
	from_node = $3;
	to_node = $4;
	pkt_type = $5;
	src_addr = $9;
	dest_addr = $10;
	pkt_id = $12

	if (event == "+" && pkt_type != "ack") 
	{
		fro = int(from_node);
		src = int(src_addr);
		if (fro == src)
		{
			sendTime[pkt_id] = time
		}
	}


	if (event == "r" && pkt_type != "ack") 
	{
		to = int(to_node);
		dst = int(dest_addr);
		if (to == dst)
		{
			receiveNum++
			recvTime[pkt_id] = time
			delay[pkt_id] = recvTime[pkt_id] - sendTime[pkt_id];
			tot_delay += delay[pkt_id];
		}
	}
}

END{
	if (receiveNum != 0) 
	{
		avg_delay = tot_delay / receiveNum
	}
	else 
	{
		avg_delay = 0
   	}
	printf("Total Delay : %f\n",tot_delay);
	printf("Received packets : %f\n",receiveNum );
	printf("avgDelay: %f s\n", avg_delay)
	printf("overall delay: %f s\n", tot_delay)
	printf("overall packet: %d\n", receiveNum)
}
