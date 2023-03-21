BEGIN {
    dropped=0;
    sentFid_1=0;
    sentFid_2=0;
}

 

{
    if($1=="s"&&$4=="AGT")
    {
        if($3=="_0_"){
            sentFid_1=sentFid_1+1;
        }
        if($3=="_4_"){
            sentFid_2=sentFid_2+1;
        }sent=sent+1;
    }
    if ($1 == "D") {
        dropped=dropped+1;


    }

}

 

END {
    printf("Number of dropped packets is %d\n",dropped);
    printf("Number of packets sent in FID_1 = %d\n",sentFid_1);
    printf("Number of packets sent in FID_2 = %d\n",sentFid_2);
}