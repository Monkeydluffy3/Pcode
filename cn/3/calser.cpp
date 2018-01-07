#include<stdio.h>
#include<string.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<unistd.h>
#include<fstream>
#include<math.h>
using namespace std;

int main()
{
	int sock_desc, client_sock, c, read_size,pos;
	struct sockaddr_in ser, cli;
	char word[2000];
	char oper[2];
	int choice,err=0;
	double number1,result;
	ofstream f1;
	
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
	
	
	
	while(read_size = recv(client_sock, &choice, sizeof(int), 0) > 0)
	{	
	    char word[2000]={};
		fflush(stdout);
		fflush(stdin);
		switch(choice)
		{
			case 1:
				//Say hello
				read_size = recv(client_sock, word, 6, 0);
				printf("Client says %s",word);
				write(client_sock, word, strlen(word));
				fflush(stdout);
				break;
				
			case 2:
				//File transfer
				f1.open("Receive.txt",ios::out);
				while(read_size = recv(client_sock, word, 2000, 0) > 0)
				{
					if(strcmp(word,"-1")==0)
						break;
					f1<<word<<'\n';
					write(client_sock, &err, sizeof(int));
					fflush(stdout);
					fflush(stdin);
					char word[2000]={};
				}
				printf("%s",word);
				f1.close();
				write(client_sock, &err, sizeof(int));
				break;
				
			case 3:
				recv(client_sock, &number1, sizeof(double), 0);
				fflush(stdout);
				fflush(stdin);
				recv(client_sock, oper, 2, 0);
				fflush(stdout);
				fflush(stdin);
				write(client_sock, &err, sizeof(int));
				fflush(stdout);
				fflush(stdin);
				switch(oper[0])
				{
					case '1':
						result = sin(number1);
						write(client_sock, &result, sizeof(double));
						break;
					case '2':
						result = cos(number1);
						write(client_sock, &result, sizeof(double));
						break;
					case '3':
						result = tan(number1);
						write(client_sock, &result, sizeof(double));
						break;
				}
				fflush(stdout);
				fflush(stdin);
				//write(client_sock, 0, sizeof(int));
				break;
		
		}	
		
		fflush(stdout);
		fflush(stdin);
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

