import java.io.*;
import java.net.*;

public class SerPeer {

	Socket socket;
	ServerSocket serverSocket;
    PrintWriter out;
    BufferedReader in ;
    BufferedReader stdIn;
	private static int portNumber;

	public SerPeer() {}

    public void connect() {

    	try {
    		serverSocket = new ServerSocket(portNumber);
    		System.out.println("Listening...");
	    	socket = serverSocket.accept();
	    	System.out.println("Connected...");

		    out = new PrintWriter(socket.getOutputStream(), true);
		    in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
		    stdIn = new BufferedReader(new InputStreamReader(System.in));
		}catch (SocketException se) {
			System.exit(0);
		}
	    catch (Exception e) {
			System.out.println(e);
		}
    }

    public void readThread() {
    	Thread read = new Thread() {
			public void run() {
		    	String data;
		    	try {
		    		while((data = in.readLine()) != null) {
		    	   		System.out.println("Client: " + data);
		    	   	}
		    	} catch (IOException e) {
		    		System.out.println("Disconnected...");
		    		System.exit(0);
		    	}
		    }
		};
		read.start();
    }

    public void writeThread() {
    	Thread write = new Thread() {
			public void run() {
		    	while(true) {
			    	try {
			    		out.println(stdIn.readLine());
			    	} catch (Exception e) {
			    		System.out.println(e);
			    	}
		    	}
		    }
		};
		write.start();
    }

 	public static void main(String[] args) throws Exception {

 		SerPeer chatServer = new SerPeer();
		portNumber = 3000;

		chatServer.connect();

		
		 	
		 	chatServer.readThread();
		    chatServer.writeThread();

		
		
	}
}
