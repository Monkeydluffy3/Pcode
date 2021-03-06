#include<stdio.h>
#include<iostream>
#include<string.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<unistd.h>
using namespace std;
int main()
{
	int sock_desc, client_sock, c;
	struct sockaddr_in ser, cli;
	
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
	
	char tmp[20];
	int i,j,k;
	//Recievce
	recv(client_sock, tmp, 20, 0);
	int sz=strlen(tmp);
	
	char err;
    cout<<"\nDo you want to introduce error (y/n): ";
    cin>>err;
    if(err=='y')
    {
        tmp[3]^=1;
    }   
	
	int gs=9;
	char g[]="100000111";
	
	cout<<"\nReceived frame : ";
    for(i=0;i<sz;i++)
        cout<<tmp[i];
    cout<<"\n";    
   
    cout<<"\nGenerator : ";
    for(i=0;i<gs;i++)
        cout<<g[i];
    cout<<"\n";    
    
    
    for(i=0;i<sz-gs+1;i++)
    {
        j=0,k=i;
        if(tmp[k]>=g[j])
        {
            for(j=0,k=i;j<gs;j++,k++)
                tmp[k]=(tmp[k]^g[j])+48;   
        }
    }
    
    int flag=1;
    cout<<"\nRemainder : ";
    for(i=0;i<gs-1;i++)
    {
        cout<<tmp[i+sz-gs+1];
        if(tmp[i+sz-gs+1]=='1')
          flag=0;      
    }
    cout<<"\n";
    
    if(flag)
    {
        cout<<"\n\nReceived!\n";
        char climsg[]="Received Successfully\n";
	    write(client_sock, climsg, strlen(climsg)+1);
	}
    
    else
    {
        cout<<"\n\nError in received data!!!\n";
        char climsg[]="Error in data\n";
	    write(client_sock, climsg, strlen(climsg)+1);
	}
	
	if(sz == 0)
	{
		puts("Client disconnected");
		fflush(stdout);
	}
	else if(sz == -1)
	{
		perror("Recv Failed");
	}
	
	close(sock_desc);
	
	return 0;
}

