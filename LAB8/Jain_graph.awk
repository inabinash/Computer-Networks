BEGIN{
	interval = 0.1
	start = 0.1
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

	if (event == "r" && pkt_type != "ack") 
	{
		to = int(to_node);
		dst = int(dest_addr);
		if (to == dst)
		{
			node_thr[f_id] += pkt_size;
		}
	}

	if (time >= start) 
	{
		for (i in node_thr)
		{
			Th = (node_thr[i]/interval)*(8/1000);
			sum += Th;
			Sq_sum += (Th*Th);
			cnt++;
			node_thr[i] = 0;
		}
		JI = ((sum*sum)/(cnt*Sq_sum));
		printf("%.2f %.2f\n",time, JI);
		start += interval
		sum = 0;
		Sq_sum = 0;
		cnt = 0;
	}
}

END{
	;
}
