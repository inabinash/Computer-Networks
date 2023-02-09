#include <stdio.h>
 
#include <stdlib.h>
 
#include <string.h>
 
#include <sys/socket.h>
 
#include <arpa/inet.h>
 
#include <netinet/in.h>
 
 
int main()
 
{
 
 int server_fd, client_fd;
 
 struct sockaddr_in server_addr, client_addr;
 
 int buffer[3], result;
 
 int i, tmp, len;
 

 
 
 // socket creation
 
 server_fd = socket(AF_INET, SOCK_DGRAM, 0);
 
 if(server_fd < 0) return 1;
 

 
 
 // binding
 
 bzero(&server_addr, sizeof(server_addr));
 
 bzero(&client_addr, sizeof(client_addr));
 

 
 
 server_addr.sin_family = AF_INET;
 
 server_addr.sin_port = htons(8080); // convert int to network bits
 
 server_addr.sin_addr.s_addr = inet_addr("127.0.0.1"); // local ip
 

 
 
 tmp = bind(server_fd, (struct sockaddr*) &server_addr, sizeof(server_addr));
 
 if(tmp < 0) return 2;
 

 
 
 printf("---------WELCOME TO SERVER APP---------\n\n");
 

 
 
 while(1)
 
 {
 
 len = sizeof(client_addr);
 

 
 
 // receive an array of two numbers
 
 recvfrom(server_fd, buffer, sizeof(buffer), 0, (struct sockaddr*) &client_addr, &len);
 
 printf("\tREQUEST RECEIVED!\n");
 

 
 
 // carry out operation
 
 switch(buffer[0]) {
 
 case 0:
 
 result = buffer[1] + buffer[2];
 
 break;
 
 case 1:
 
 result = buffer[1] - buffer[2];
 
 break;
 
 case 2:
 
 result = buffer[1] * buffer[2];
 
 break;
 
 case 3:
 
 result = buffer[1] / buffer[2];
 
 break;
 
 case 4:
 
 result = 1;
 
 for(i = 2; i < buffer[1]; i++) {
 
 if(buffer[1] % i == 0) {
 
 result = 0;
 
 }
 
 }
 
 break;
 
 default:
 
 printf("Invalid choice!\n");
 
 exit(1);
 
 }
 
 
 // send the result
 
 sendto(server_fd, &result, sizeof(&result), 0, (struct sockaddr*) &client_addr, sizeof(client_addr));
 
 
 printf("\tRESPONSE SENT!\n");
 
 }
 
 
 return 0;
 
}
 