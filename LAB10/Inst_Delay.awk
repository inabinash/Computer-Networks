BEGIN{
	receiveNum = 0;
    interval=0.1;
    start=0.1;

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
    if($2>=start){
    if (receiveNum != 0) 
	{
		avg_delay = tot_delay / receiveNum
	}
	else 
	{
		avg_delay = 0
   	}
	printf("%.2f %f s\n",time, avg_delay);
    start+=interval;
    avg_delay=0;
    receiveNum=0;
    tot_delay=0;
    for( i in recvTime){
        recvTime[i]=0;
        sendTime[i]=0;
        delay[i]=0;
    }
	
    }
}

END{
	;
}
