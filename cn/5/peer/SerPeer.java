import java.io.*;
import java.net.*;
import java.util.*;

public class SerPeer {

	DatagramSocket socket;
	BufferedReader in;
	DatagramPacket packet;
	byte[] buf;
	InetAddress address;
	int port;

	SerPeer() {}

	public void connect() {
		try {
			socket = new DatagramSocket(3000);
			in = new BufferedReader(new InputStreamReader(System.in));

			System.out.println("Server Started...");
			buf = new byte[256];
			packet = new DatagramPacket(buf, buf.length);
			socket.receive(packet);
			address = packet.getAddress();
			port = packet.getPort();
			System.out.println("Client connected...");

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
						System.out.println("Client: " + received);
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
		SerPeer chatServer = new SerPeer();
		chatServer.connect();
		chatServer.readThread();
		chatServer.writeThread();
	}
}
