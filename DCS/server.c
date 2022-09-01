#include <sys/socket.h>
#include <sys/types.h>
#include <sys/un.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#define BACKLOG 2
#define BUFFER_SIZE 50
#define SOCKET_NAME "/tmp/utsav.socket"

int main() 
{
    printf("server starting...\n");

    struct sockaddr_un addr;
    int listen_socket;
    int client_socket;
    int ret;
    char buffer[BUFFER_SIZE];

    // Unlink socket if something occured during last run
    unlink(SOCKET_NAME);

    // Create socket
    listen_socket = socket(AF_UNIX, SOCK_SEQPACKET, 0);
    if(listen_socket < 0) {
        perror("socket");
        exit(EXIT_FAILURE);
    }

    // Setup socket address family
    memset(&addr, 0, sizeof(struct sockaddr_un));

    // Bind socket
    addr.sun_family = AF_UNIX;
    strncpy(addr.sun_path, SOCKET_NAME, sizeof(addr.sun_path)-1);

    ret = bind(listen_socket, (const struct sockaddr*)&addr, sizeof(struct sockaddr_un));
    if(ret < 0) {
        perror("bind");
        exit(EXIT_FAILURE);
    }

    // Listen for client connection
    printf("Server is listening...\n");
    ret = listen(listen_socket, BACKLOG);
    if(ret < 0){
        perror("listen");
        exit(EXIT_FAILURE);
    }
    
    while(1)
    {
        // Accept client connection
        client_socket = accept(listen_socket, NULL, NULL);
        if(client_socket < 0) {
            perror("accept");
            exit(EXIT_FAILURE);
        }

        // Handle client connection
        while(1)
        {
            // Read data from client
            ret = read(client_socket, buffer, BUFFER_SIZE);
            if(ret < 0) {
                perror("read");
                exit(EXIT_FAILURE);
            }

            // Make sure buffer is 0-terminated
            buffer[BUFFER_SIZE-1] = 0;

            // Print content of buffer
            printf("Received data: %s\n", buffer);

            // Write content to buffer
            sprintf(buffer, "@server--> pong");

            // Send data to client
            ret = write(client_socket, buffer, BUFFER_SIZE);
            if(ret < 0) {
                perror("write");
                exit(EXIT_FAILURE);
            }

            sleep(1);
        }
        close(listen_socket);

        unlink(SOCKET_NAME);
        
        exit(EXIT_SUCCESS);
    }

    return 0;
}
