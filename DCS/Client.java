import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.Scanner;

public class Client
{
	public static void main(String[] args) throws IOException
	{
		InetAddress ip = InetAddress.getByName("192.168.48.138");
		int port = 4444;
		Scanner sc = new Scanner(System.in);

		// Step 1: Open the socket connection.
		Socket s = new Socket(ip, port);

		// Step 2: Communication-get the input_bufut and output stream
		DataInputStream dis = new DataInputStream(s.getInputStream());
		DataOutputStream dos = new DataOutputStream(s.getOutputStream());

		while (true)
		{
			// Enter the equation in the form-
			// "operand1 operation operand2"
			System.out.print("Enter the equation in the form: ");
			System.out.println("'operand operator operand'");

			String input_buf = sc.nextLine();

			if (input_buf.equals("bye"))
				break;

			// send the equation to server
			dos.writeUTF(input_buf);

			// wait till request is processed and sent back to client
			String ans = dis.readUTF();
			System.out.println(input_buf + " = " + ans);
		}
	}
}
