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
    printf("Client started...\n");

    struct sockaddr_un addr;
    int i;
    int ret;
    int client_socket;
    char buffer[BUFFER_SIZE];

    // Create socket
    client_socket = socket(AF_UNIX, SOCK_SEQPACKET, 0);
    if(client_socket < 0) {
        perror("socket");
        exit(EXIT_FAILURE);
    }

    // Setup socket address family
    memset(&addr, 0, sizeof(struct sockaddr_un));

    // Connect socket to socket address
    addr.sun_family = AF_UNIX;
    strncpy(addr.sun_path, SOCKET_NAME, sizeof(addr.sun_path)-1);

    ret = connect(client_socket, (const struct sockaddr*)&addr, sizeof(struct sockaddr_un));
    if(ret < 0) {
        perror("connect");
        exit(EXIT_FAILURE);
    }

    while(1) 
    {
        // Write data to buffer
        sprintf(buffer, "@client--> ping");

        // Send data to server
        ret = write(client_socket, buffer, BUFFER_SIZE);
        if(ret < 0) {
            perror("write");
            exit(EXIT_FAILURE);
        }

        // Receive response from server
        ret = read(client_socket, buffer, BUFFER_SIZE);
        if(ret < 0) {
            perror("read");
            exit(EXIT_FAILURE);
        }

        // Ensure buffer is 0-terminated
        buffer[BUFFER_SIZE-1] = 0;

        // Print content in buffer
        printf("Response from server: %s\n", buffer);

        sleep(1);
    }

    // Close socket
    close(client_socket);

    exit(EXIT_SUCCESS);

    return 0;
}
