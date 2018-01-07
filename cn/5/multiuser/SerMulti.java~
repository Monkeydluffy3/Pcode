import java.io.*;
import java.net.*;
import java.util.*;

public class SerMulti {

	DatagramSocket socket;
	BufferedReader in;
	DatagramPacket packet;
	byte[] buf;
	
	int port = 4446;
	InetAddress address;

	SerMulti() {}
	public void connect() {
		try {
			socket = new DatagramSocket(4445);
			in = new BufferedReader(new InputStreamReader(System.in));
			address = InetAddress.getByName("224.0.0.1");
			System.out.println("Server Started...");
			
				
			

		} catch(Exception e) {
			System.out.println(e);
		}
		
	}

	public void readThread() {
		Thread read = new Thread() {
			public void run() {
				String received;
				try {
					while(true) {
						buf = new byte[256];
						packet = new DatagramPacket(buf, buf.length);
						socket.receive(packet);
						received = new String(packet.getData(), 0, packet.getLength());
						
						buf = new byte[256];
						buf = received.getBytes();
						packet = new DatagramPacket(buf, buf.length, address, port);
		        		socket.send(packet);
					}
				} catch (Exception e) {
					System.out.println(e);
					System.exit(0);
				}
			}
		};

		read.setPriority(Thread.MAX_PRIORITY);
		read.start();
	}
	
	public static void main(String[] args) throws Exception {
		SerMulti chatServer = new SerMulti();
		chatServer.connect();
		chatServer.readThread();
		
	}
}
