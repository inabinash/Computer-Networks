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
   struct sockaddr_in servaddr;
   int n, len;
   int num1, num2, result;


   // Creating socket file descriptor
   sockfd = socket(AF_INET, SOCK_DGRAM, 0);
   if (sockfd < 0) {
       perror("socket creation failed");
       exit(EXIT_FAILURE);
   }


   memset(&servaddr, 0, sizeof(servaddr));


   // Filling server information
   servaddr.sin_family = AF_INET;
   servaddr.sin_port = htons(PORT);
   servaddr.sin_addr.s_addr = INADDR_ANY;


   while (1) {
       printf("Enter two numbers to add: ");
       scanf("%d%d", &num1, &num2);


       sendto(sockfd, (const int *)&num1, sizeof(int),
              0, (const struct sockaddr *)&servaddr,
              sizeof(servaddr));
       sendto(sockfd, (const int *)&num2, sizeof(int),
              0, (const struct sockaddr *)&servaddr,
              sizeof(servaddr));


       n = recvfrom(sockfd, (int *)&result, sizeof(int),
                    0, NULL, NULL);
      
       if (n == sizeof(int)) {
           printf("Result: %d\n", result);
       } else {
           printf("Error receiving result\n");
       }
   }


   return 0;
}

 