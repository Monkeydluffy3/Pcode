#include<stdio.h>
#include<string.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<unistd.h>
#include<math.h>
#include<fstream>
using namespace std;

int main()
{
	int sock, c, read_size, client_sock;
	struct sockaddr_in ser, cli;
	char word[2000], oper[2], erro[2000];
	int choice,err = 0;
	double number1,result;
	ifstream f1;
	
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
		char word[2000]={};
		printf("\n\n1.Say Hello\n2.File Transfer\n3.Calculator");
		printf("\nEnter choice=");
		scanf("%d",&choice);
		send(sock, &choice, sizeof(int), 0 );
		switch(choice)
		{	
			fflush(stdout);
			fflush(stdin);
			case 1:
				strcpy(word,"Hello");
				if( send(sock, word, strlen(word), 0 ) < 0)
				{
					puts("\nSend Failed");
					return 1;
				}
		
				if( recv(sock, word, 6, 0) < 0)
				{
					puts("\nrecv Failed");
					break;
				}
				printf("\nServer says %s", word);
				fflush(stdout);
				fflush(stdin);
				break;
			case 2:
				f1.open("ques.txt",ios::in);
				while(!f1.eof())
				{
					if(f1.eof())
						break;
					f1.getline(word,2000);
					if( send(sock, word, strlen(word), 0 ) < 0)
					{
						puts("\nSend Failed");
						break;
					}
					if( recv(sock, &err, sizeof(int), 0) < 0)
					{
						puts("\nrecv Failed");
						break;
					}
					char word[2000]={};
					fflush(stdout);
					fflush(stdin);
				}
				strcpy(erro,"-1");
				printf("%s\n",erro);
				fflush(stdout);
				fflush(stdin);
				if( send(sock, erro, strlen(erro), 0 ) < 0)
					{
						puts("\nSend Failed");
						break;
					}
					
				if( recv(sock, &err, sizeof(int), 0) < 0)
					{
						puts("\nrecv Failed");
						break;
					}
					
				f1.close();
				fflush(stdout);
				fflush(stdin);
				break;
			case 3:
				printf("Enter number1=");
				scanf("%lf",&number1);
				printf("Enter operator(1.sin 2.cos 3.tan) : ");
				scanf("%s",oper);
				fflush(stdout);
				fflush(stdin);
				if( send(sock, &number1, sizeof(double), 0 ) < 0)
				{
					puts("\nSend Failed");
					break;
				}
				fflush(stdout);
				fflush(stdin);
				if( send(sock, oper, sizeof(oper), 0 ) < 0)
				{
					puts("\nSend Failed");
					break;
				}	
				fflush(stdout);
				fflush(stdin);
				if( recv(sock, &err, sizeof(int), 0) < 0)
				{
					puts("\nrecv Failed");
					break;
				}
				recv(sock, &result, sizeof(double), 0);
				printf("\nResult = %lf",result);
				fflush(stdout);
				fflush(stdin);
				break;
			default:printf("\nWrong choice");
		}
		fflush(stdout);
		fflush(stdin);
		
	}
	close(sock);
	
	return 0;
}


