import java.io.*;
import java.net.*;
import java.util.*;

public class CliMulti {

	MulticastSocket socket;
	DatagramSocket socketData;
	int port = 4445;
	InetAddress addressBroad;
	InetAddress addressDirect;
	BufferedReader in;
	DatagramPacket packet;
	byte[] buf;
	String name;

	CliMulti() {}

	public void connect() {
		try {


			socket = new MulticastSocket(4446);
			addressBroad = InetAddress.getByName("224.0.0.1");
			socket.joinGroup(addressBroad);
			System.out.println("Client connected...");
			in = new BufferedReader(new InputStreamReader(System.in));
			System.out.print("Enter Screen name: ");
			name = in.readLine();
			String sent;
			sent = name + " joined chat...";
			buf = new byte[256];
			buf = sent.getBytes();
			addressDirect = InetAddress.getByName("localhost");
			packet = new DatagramPacket(buf, buf.length, addressDirect, port);
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
						sent = name + ": " + sent;
						buf = new byte[256];
						buf = sent.getBytes();
						packet = new DatagramPacket(buf, buf.length, addressDirect, port);
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
						System.out.println(received);
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
		
        CliMulti chatClient = new CliMulti();
        chatClient.connect();

        chatClient.writeThread();
        chatClient.readThread();
	}
}
