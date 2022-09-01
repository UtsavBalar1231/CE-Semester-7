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
    message.msg_type = 1;

    printf("data write: ");
    fgets(message.mesg_text, 12, stdin);

    msgsnd(id, &message, sizeof(message), 0);

    printf("sent data: %s \n", message.mesg_text);
}
