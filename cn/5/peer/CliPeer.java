import java.io.*;
import java.net.*;
import java.util.*;

public class CliPeer {

	DatagramSocket socket;
	String add  = "localhost";
	int port = 3000;
	InetAddress address;
	BufferedReader in;
	DatagramPacket packet;
	byte[] buf;

	CliPeer() {}

	public void connect() {
		try {
			socket = new DatagramSocket();
			System.out.println("Client connected...");
			in = new BufferedReader(new InputStreamReader(System.in));
			address = InetAddress.getByName(add);
			buf = new byte[256];
			packet = new DatagramPacket(buf, buf.length, address, port);
    		socket.send(packet);
			} catch(Exception e) {
				System.out.println(e);
			}
		
	}

	public void writeThread() {
		Thread write = new Thread() {
			public void run() {
				String sent;
				try {
					while(true) {
						sent = in.readLine();
						buf = new byte[256];
						buf = sent.getBytes();
						packet = new DatagramPacket(buf, buf.length, address, port);
		        		socket.send(packet);
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
						System.out.println("Server: " + received);
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
		
        CliPeer chatClient = new CliPeer();
        chatClient.connect();

        chatClient.writeThread();
        chatClient.readThread();
	}
}
