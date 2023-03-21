#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>


#define PORT 12345
#define MAX_LEN 1024


int main(int argc, char *argv[]) {
   int sockfd;
   struct sockaddr_in servaddr, cliaddr;
   int n, len;
   int num1, num2, result;


   // Creating socket file descriptor
   sockfd = socket(AF_INET, SOCK_DGRAM, 0);
   if (sockfd < 0) {
       perror("socket creation failed");
       exit(EXIT_FAILURE);
   }


   memset(&servaddr, 0, sizeof(servaddr));
   memset(&cliaddr, 0, sizeof(cliaddr));


   // Filling server information
   servaddr.sin_family = AF_INET;
   servaddr.sin_port = htons(PORT);
   servaddr.sin_addr.s_addr = htonl(INADDR_ANY);


   // Bind the socket with the server address
   if (bind(sockfd, (const struct sockaddr *)&servaddr,
            sizeof(servaddr)) < 0) {
       perror("bind failed");
       exit(EXIT_FAILURE);
   }


   len = sizeof(cliaddr);


   while (1) {
    printf("Server is waiting to add ...\n");
       n = recvfrom(sockfd, (int *)&num1, sizeof(int),
                    0, (struct sockaddr *)&cliaddr,
                    &len);
       if (n < 0) {
           perror("Error receiving num1");
           continue;
       }


       n = recvfrom(sockfd, (int *)&num2, sizeof(int),
                    0, (struct sockaddr *)&cliaddr,
                    &len);
       if (n < 0) {
           perror("Error receiving num2");
           continue;
       }


       result = num1 + num2;
        

       sendto(sockfd, (const int *)&result, sizeof(int),
              0, (const struct sockaddr *)&cliaddr, len);
   }


   return 0;
}