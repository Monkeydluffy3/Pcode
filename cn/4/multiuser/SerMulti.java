import java.io.*;
import java.net.*;
import java.util.HashSet;

public class SerMulti {

	
	ServerSocket serverSocket;
	private static int portNumber;
	private static HashSet<PrintWriter> writers = new HashSet<PrintWriter>();


	public SerMulti() {
		try {
			serverSocket = new ServerSocket(portNumber);
    		System.out.println("Listening...");
	    	} catch (Exception e){}
	}

    public void connect() {
    	try {
	    	while(true) {
	    		new Handler(serverSocket.accept()).start();
	    		
			}
			
		}catch (SocketException se) {
			System.exit(0);
		}
	    catch (Exception e) {
			System.out.println(e);
		} finally {
			try {serverSocket.close();}
			catch(Exception e){}
		}
		
    }

    

 	public static void main(String[] args) throws Exception {

 		portNumber = 3000;
 		SerMulti chatServer = new SerMulti();
		chatServer.connect();
	 		
	}


private static class Handler extends Thread {
	Socket socket = null;
	PrintWriter out;
    BufferedReader in ;
    BufferedReader stdIn;

    public Handler(Socket socket) {
            this.socket = socket;
        }

    public void run() {
    	try {
    		System.out.println("Connected...");

		    out = new PrintWriter(socket.getOutputStream(), true);
		    writers.add(out);

		    in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
		    stdIn = new BufferedReader(new InputStreamReader(System.in));
		    
		    readThread();
		    
    	} catch (Exception e) {
    		System.out.println(e);
    		try {
	    		if (out != null) {
                    writers.remove(out);
                }
                socket.close();}
    		catch(Exception se){}
    	}
    }

    public  void readThread() {
    	Thread read = new Thread() {
			public void run() {
		    	String data;
		    	try {
		    		while((data = in.readLine()) != null) {
		    			for (PrintWriter writer : writers) {
	                        writer.println(data);
	                    }
		    	   		//System.out.println(data);
		    	   	}
		    	} catch (IOException e) {
		    		System.out.println("Disconnected...");
		    		//System.exit(0);
		    	}
		    }
		};
		read.setPriority(Thread.MAX_PRIORITY);
		read.start();
    }
}
}
