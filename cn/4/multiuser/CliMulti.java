import java.io.*;
import java.net.*;

public class CliMulti {

	Socket socket;
	PrintWriter out;
	BufferedReader in;
	BufferedReader stdIn;
	static String hostName;
	static int portNumber;
	static String name;

	CliMulti() {}

	void connect() {
		try {
		    socket = new Socket(hostName, portNumber);

		    System.out.println("Connected...");
		    out = new PrintWriter(socket.getOutputStream(), true);
		    in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
		    stdIn = new BufferedReader(new InputStreamReader(System.in));

		    System.out.print("Enter your screen name: ");
		    name = stdIn.readLine();
		    out.println(name + " joined chat...");

		} catch (Exception e) {
			System.out.println(e);
		}
	}

	void readThread() {
		Thread read = new Thread() {
			public void run() {
				while(true) {
					try {
						System.out.println(in.readLine());
					} catch(Exception e) {
						System.out.println(e);
						System.exit(0);
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
		    			 {
			    			out.println(name + ": " + data);
			    			sleep(100);
			    		}

		    			data = null;
		    		}
		    	} catch (Exception e) {
		    		System.out.println(e);
		    		System.exit(0);
		    	}
		    }
		};
		write.setPriority(Thread.MAX_PRIORITY);
		write.start();
	}
	
	public static void main(String[] args) throws Exception{


		hostName = "localhost";
		portNumber = 3000;
		CliMulti chatClient = new CliMulti();
		chatClient.connect();
		
		chatClient.writeThread();
	    chatClient.readThread();
		
	}
}
