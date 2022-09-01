#include <stdio.h>
#include <sys/ipc.h>
#include <sys/msg.h>

struct msg_buffer
{
    long msg_type;
    char mesg_text[100];
} message;

void main()
{
    key_t key;
    int id;

    key = ftok("file", 65);

    id = msgget(key, 0666 | IPC_CREAT);

    msgrcv(id, &message, sizeof(message), 1, 0);

    printf("received data: %s \n", message.mesg_text);

    msgctl(id, IPC_RMID, NULL);
}
