import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.net.Socket;
import java.util.Scanner;

public class Client {
	public static void main(String[] args) throws IOException {
		InetAddress ip = InetAddress.getByName("127.0.0.1");
		int port = 4444;
		try (Scanner sc = new Scanner(System.in)) {
			try (Socket s = new Socket(ip, port)) {
				DataInputStream dis = new DataInputStream(s.getInputStream());
				DataOutputStream dos = new DataOutputStream(s.getOutputStream());

				boolean retry = true;
				while (retry) {
					System.out.println("Enter equation: ");
					String input = sc.nextLine();
					dos.writeUTF(input);
					String result = dis.readUTF();
					System.out.println("Result: " + result);
					System.out.println("Do you want to continue? (y/n)");
					String answer = sc.nextLine();
					if (answer.equals("n")) {
						retry = false;
					}
				}
			}
		}
	}
}