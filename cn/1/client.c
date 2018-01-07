#include<stdio.h>
#include<string.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<unistd.h>

int main()
{
	int sock, c, read_size, client_sock;
	struct sockaddr_in ser, cli;
	char message[2000], server_reply[2000];
	
	//Socket creation
	sock= socket(AF_INET, SOCK_STREAM, 0);
	if(sock <0)
	{
		printf("Could not create socket\n");
		return 1;
	}
	puts("Socket Created");
	
	//Prepare the sockaddr_in struct
	ser.sin_family = AF_INET;
	ser.sin_addr.s_addr = inet_addr("127.0.0.1");
	ser.sin_port = htons(8888);
	
	//Connect
	if( connect(sock, (struct sockaddr *)&ser, sizeof(ser)) < 0)
	{
		printf("Connect Failed");
		return 1;
	}
	puts("Connected\n");
	
	//keep communcating
	while(1)
	{
		printf("Enter Message = ");
		scanf("%s", message);
		
		if( send(sock, message, strlen(message), 0 ) < 0)
		{
			puts("Send Failed");
			return 1;
		}
		
		/*if( recv(sock, server_reply, 2000, 0) < 0)
		{
			puts("recv Failed");
			break;
		}
		
		puts("Server Reply =");
		puts(server_reply);*/
	}
	close(sock);
	
	return 0;
}

