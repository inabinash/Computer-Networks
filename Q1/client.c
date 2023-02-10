#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>

int main(){
    int sid;char c;
    struct sockaddr_in server_address;
    server_address.sin_family=AF_INET ;
    server_address.sin_addr.s_addr=inet_addr("127.0.0.1");
    server_address.sin_port=5080;

    int server_addlen=sizeof(server_address);
    sid= socket(AF_INET,SOCK_STREAM,0);
    connect(sid,(struct sockaddr_in *)&server_address,server_addlen);
    write(sid,"B",1);
    read(sid,&c,1);
    printf("The received character is %c\n",c);
    close(sid);
    return 0;

}