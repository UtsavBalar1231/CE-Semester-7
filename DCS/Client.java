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
			// Step 1: Open the socket connection.
			try (Socket s = new Socket(ip, port)) {
				// Step 2: Communication-get the inputBuffer and output stream
				DataInputStream dis = new DataInputStream(s.getInputStream());
				DataOutputStream dos = new DataOutputStream(s.getOutputStream());

				while (true) {
					// Enter the equation in the form "operand1 operation operand2"
					System.out.print("Enter the equation: ");
					System.out.println("example: (number * number)");
					System.out.println("");

					// wait for input
					String inputBuffer = sc.nextLine();

					// If client sends exit,close this connection
					if (inputBuffer.equals("exit"))
						break;

					// send the equation to server
					dos.writeUTF(inputBuffer);

					// wait till request is processed and sent back to client
					String ans = dis.readUTF();
					System.out.println(inputBuffer + " = " + ans);
				}
			}
		}
	}
}
