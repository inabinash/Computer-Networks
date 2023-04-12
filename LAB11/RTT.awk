BEGIN{
   interval=1;
   start=0.1;
   cnt1=0;
   cnt2=0;
   receiveNumber=0;

}

{
    event=$1
    time=$2
    from_node=$3
    to_node=$4
    pkt_type=$5
    src_addr = $9;
	dest_addr = $10;

    if(event=="+" && pkt_type=="tcp"){
        fro=int(from_node);
        src=int(src_addr);
        if(fro==src){
            sendTime[cnt1]=time;
            cnt1=cnt1+1;
        }
    }
    if(event=="r"&& pkt_type=="ack"){
        to=int(to_node);
        dest=int(dest_addr);
        if(to==dest){
            receiveNumber=receiveNumber+1;
            recvTime[cnt2]=time;
            
            #printf("Send Time %.2f Receive Time %.2f Count %d",sendTime[cnt2],receiveTime[cnt2],cnt2);
            rtt[cnt2]=recvTime[cnt2]-sendTime[cnt2];
            
            tot_rtt+=rtt[cnt2];
            cnt2=cnt2+1;
        }
    }

    if($2>=start){
        if(receiveNumber!=0)
        {
            avg_rtt=(tot_rtt)/receiveNumber;
        }
        else{
            avg_rtt=0;
        }
        printf("%.2f %f \n",time , avg_rtt);
        start+=interval;
        avg_rtt=0;
        receiveNumber=0;
        tot_rtt=0;
        for( i in recvTime){
        recvTime[i]=0;
        sendTime[i]=0;
        rtt[i]=0;
    }
    }

}

END{
    ;
}