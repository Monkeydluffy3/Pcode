#include<stdio.h>
#include<string.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<unistd.h>

int main()
{
	int sock_desc, client_sock, c, read_size;
	struct sockaddr_in ser, cli;
	char climsg[2000];
	
	//Socket creation
	sock_desc = socket(AF_INET, SOCK_STREAM, 0);
	if(sock_desc <0)
	{
		printf("Could not create socket\n");
		return 1;
	}
	puts("Socket Created");
	
	//Prepare the sockaddr_in struct
	ser.sin_family = AF_INET;
	ser.sin_addr.s_addr = INADDR_ANY;
	ser.sin_port = htons(8888);
	
	//bind
	if( bind(sock_desc, (struct sockaddr *)&ser, sizeof(ser)) < 0)
	{
		printf("Bind Failed");
		return 1;
	}
	puts("Bind Done");
	
	//Listen
	listen(sock_desc, 3);
	
	//Accept incomin
	puts("Waiting for incoming connection");
	c = sizeof(struct sockaddr_in);
	
	//accept connection
	client_sock = accept(sock_desc, (struct sockaddr *)&cli, (socklen_t*)&c);
	if(client_sock < 0)
	{
		printf("Accept Failed");
		return 1;
	}
	puts("Connection Accepted");
	
	//Recievce
	while(read_size = recv(client_sock, climsg, 2000, 0) > 0)
	{	
		//write(client_sock, climsg, strlen(climsg));
		printf("%s\n",climsg);
		fflush(stdout);
	}
	if(read_size == 0)
	{
		puts("Client disconnected");
		fflush(stdout);
	}
	else if(read_size == -1)
	{
		perror("Recv Failed");
	}
	
	close(sock_desc);
	
	return 0;
}

