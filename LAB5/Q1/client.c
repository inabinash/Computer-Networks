#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>


int main(){
    int sid;char c;
    struct sockaddr_in server_address;
    int server_addlen;
    server_address.sin_family=AF_INET;
    server_address.sin_addr.s_addr=inet_addr("127.0.0.1");
    server_address.sin_port=7890;

    server_addlen=sizeof(server_address);
    sid=socket(AF_INET,SOCK_DGRAM,0);
    sendto(sid,"A",1,0,(struct sockaddr *)&server_address,server_addlen);
    recvfrom(sid,&c,1,0,(struct sockaddr *)&server_address,&server_addlen);
    printf("Character from server is %c\n",c);
    return 0;



}