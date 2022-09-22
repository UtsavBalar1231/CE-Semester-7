
// Java program to illustrate Server Side Programming
// for Simple Calculator using TCP
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.StringTokenizer;

public class CalculateServer {
    public static void main(String args[]) throws IOException {

        // Step 1: Establish the socket connection.
        ServerSocket ss = new ServerSocket(4444);
        Socket s = ss.accept();

        // Step 2: Processing the request.
        DataInputStream dis = new DataInputStream(s.getInputStream());
        DataOutputStream dos = new DataOutputStream(s.getOutputStream());

        while (true) {
            // wait for input
            String input = dis.readUTF();

            if (input.equals("exit"))
                break;

            System.out.println("Equation received:-" + input);
            int result = 0;

            // Use StringTokenizer to break the equation into operand and
            // operation
            StringTokenizer st = new StringTokenizer(input);

            int number1 = Integer.parseInt(st.nextToken());
            String operation = st.nextToken();
            int number2 = Integer.parseInt(st.nextToken());

            System.out.println("Sending the result...");

            // perform the required operation.
            if (operation.equals("*")) {
                result = number1 * number2;
                // send the result back to the client.
                dos.writeUTF(Integer.toString(result));
            } else {
                System.out.println("Operation not supported");
            }
        }
    }
}
