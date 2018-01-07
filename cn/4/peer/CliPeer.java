import java.io.*;
import java.net.*;

public class CliPeer {

	Socket socket;
	PrintWriter out;
	BufferedReader in;
	BufferedReader stdIn;
	static String hostName;
	static int portNumber;

	CliPeer() {}

	void connect() {
		try {
		    socket = new Socket(hostName, portNumber);
		    System.out.println("Connected...");
		    out = new PrintWriter(socket.getOutputStream(), true);
		    in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
		    stdIn = new BufferedReader(new InputStreamReader(System.in));
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	void readThread() {
		Thread read = new Thread() {
			public void run() {
				while(true) {
					try {
						System.out.println("Server: " + in.readLine());
					} catch(Exception e) {
						System.out.println(e);
					}
				}
			}
		};
		read.setPriority(Thread.MAX_PRIORITY);
		read.start();
	}

	void writeThread() {
		Thread write = new Thread() {
			public void run() {
				String data;
				try {
					while((data = stdIn.readLine()) != null) {
		    			out.println(data);
		    			data = null;
		    		}
		    	} catch (Exception e) {
		    		System.out.println(e);
		    	}
		    }
		};
		write.setPriority(Thread.MAX_PRIORITY);
		write.start();
	}
	
	public static void main(String[] args) throws Exception{

		hostName = "localhost";
		portNumber = 3000;
		CliPeer chatClient = new CliPeer();
		chatClient.connect();
		    
		    
		    chatClient.writeThread();
		    chatClient.readThread();
		
		

		
		
	}
}