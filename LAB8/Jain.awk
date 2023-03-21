BEGIN{
	sum = 0;
	Sq_sum = 0;
	cnt = 0;
	JI = 0;
}

{
	event = $1
	time = $2
	from_node = $3;
	to_node = $4;
	pkt_type = $5;
	pkt_size = $6;
	f_id = $8;
	src_addr = $9;
	dest_addr = $10;
	pkt_id = $12

	if (event == "+" && pkt_type != "ack") 
	{
		fro = int(from_node);
		src = int(src_addr);
		if (fro == src)
		{
			if (sendTime[f_id] == 0 || time < sendTime[f_id]) 
    		{
    		    sendTime[f_id] = time
    		}
		}
	}


	if (event == "r" && pkt_type != "ack") 
	{
		to = int(to_node);
		dst = int(dest_addr);
		if (to == dst)
		{
			if (time > recvTime[f_id])
    		{
    		    recvTime[f_id] = time
    		}
			recvTime[f_id] = time
			node_thr[f_id] += pkt_size;
		}
	}
}

END{
	for (i in node_thr)
	{
		Th = (node_thr[i]/(recvTime[i] - sendTime[i]))*(8/1000);
		sum += Th;
		Sq_sum += (Th*Th);
		cnt++;
	}
	JI = ((sum*sum)/(cnt*Sq_sum));
	printf("\nJain Index = %f\n", JI);
}
