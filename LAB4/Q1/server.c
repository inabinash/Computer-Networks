#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
int main()
{
int serid, sessid;
char c;
struct sockaddr_in server_address, client_address;
int server_addlen, client_addlen;
server_address.sin_family = AF_INET;
server_address.sin_addr.s_addr = inet_addr("127.0.0.1");
server_address.sin_port = 5080;
server_addlen = sizeof(server_address);
client_addlen = sizeof(client_addlen);
serid = socket(AF_INET, SOCK_STREAM, 0);


bind(serid, (struct sockaddr *)&server_address, server_addlen); 

listen(serid, 10);
while (1)
{
printf("Server is ready to accept ......\n");
sessid = accept(serid, (struct sockaddr *)&client_address, &client_addlen);
read(sessid, &c, 1);
write(sessid, &c, 1);
close(sessid);
}
return (0);
}