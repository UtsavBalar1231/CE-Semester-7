import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.StringTokenizer;

public class CalculateServer {
    public static void main(String args[]) throws IOException {

        try (ServerSocket ss = new ServerSocket(4444)) {
            Socket s = ss.accept();

            DataInputStream dis = new DataInputStream(s.getInputStream());
            DataOutputStream dos = new DataOutputStream(s.getOutputStream());

            while (true) {
                String input = dis.readUTF();

                if (input.equals("exit"))
                    break;

                System.out.println("Equation received: " + input);
                int result = 0;

                StringTokenizer st = new StringTokenizer(input);

                int number1 = Integer.parseInt(st.nextToken());
                String operation = st.nextToken();
                int number2 = Integer.parseInt(st.nextToken());

                System.out.println("Sending result!");

                if (operation.equals("*")) {
                    result = number1 * number2;
                    dos.writeUTF(Integer.toString(result));
                } else {
                    System.out.println("Operation not supported");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}