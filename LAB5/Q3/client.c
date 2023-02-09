#include <stdio.h>
 
#include <stdlib.h>
 
#include <string.h>
 
#include <sys/socket.h>
 
#include <arpa/inet.h>
 
#include <netinet/in.h>
 
 
int main()
 
{
 
 int client_fd;
 
 struct sockaddr_in server_addr;
 
 int res = 0;
 
 int len, *result = &res, first, second, choice;
 
 int buffer[3]; // buffer[0] = operation
 

 
 
 // socket creation
 
 client_fd = socket(AF_INET, SOCK_DGRAM, 0);
 

 
 
 bzero(&server_addr, sizeof(server_addr));
 
 server_addr.sin_family = AF_INET;
 
 server_addr.sin_port = htons(8080); // convert int to network bits
 
 server_addr.sin_addr.s_addr = inet_addr("127.0.0.1"); // local ip
 
 //server_addr.sin_addr.s_addr = inet_addr("192.168.124.61");
 

 
 
 len = sizeof(server_addr);
 

 
 
 printf("---------WELCOME TO CLIENT APP---------\n\n");
 

 
 
 // choice of operation
 
 printf("Which operation would you like to do?\n\t0: Addition\n\t1: Subtraction\n\t2: Multiplication\n\t3: Division\n\t4: Detect Prime Number\n\n>>");
 
 scanf("%d", &choice);
 
 buffer[0] = choice;
 

 
 
 if(choice == 4) {
 
 printf("Enter a number: ");
 
 scanf("%d", &first);
 
 second = 0;
 
 } else if (choice >= 0 || choice <= 3) { 
 
 printf("Enter two numbers: ");
 
 scanf("%d %d", &first, &second);
 
 } else {
 
 printf("INVALID CHOICE!\n");
 
 exit(1);
 
 }
 
 // the numbers
 
 buffer[1] = first;
 
 buffer[2] = second;
 

 
 
 // send numbers to server
 
 sendto(client_fd, buffer, sizeof(buffer), 0, (struct sockaddr*) &server_addr, sizeof(server_addr));
 

 
 
 printf("\tREQUEST SENT!\n");
 
 printf("waiting for server to respond...\n\n");
 

 
 
 recvfrom(client_fd, result, sizeof(result), 0, (struct sockaddr*) &server_addr, &len);
 
 printf("\tRESPONSE RECEIVED!\n");
 

 
 
 printf("Result: %d\n", *result);
 

 
 

 
 
 return 0;
 
}
 