import java.io.*;
import java.net.*;
import java.util.*;

public class Client {
    public static void main(String args[]) throws Exception {
        // Create a socket to connect to the server
        DatagramSocket clientSocket = new DatagramSocket();

        // Get the IP address of the server
        InetAddress IPAddress = InetAddress.getByName("localhost");

        // Create a buffer to hold the message
        byte[] sendData = new byte[1024];

        // Create a buffer to hold the incoming message
        byte[] receiveData = new byte[1024];

        // Create a scanner to read the message from the user
        Scanner inFromUser = new Scanner(System.in);

        // Read the message from the user
        String sentence = inFromUser.nextLine();

        // Convert the message to bytes
        sendData = sentence.getBytes();

        // Create a datagram packet to send the message
        DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, IPAddress, 9876);

        // Send the message to the server
        clientSocket.send(sendPacket);

        // Create a datagram packet to receive the message
        DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);

        // Receive the message from the server
        clientSocket.receive(receivePacket);

        // Convert the message to a string
        String modifiedSentence = new String(receivePacket.getData());

        // Print the message
        System.out.println("Server sent: " + modifiedSentence);

        // Close the socket
        clientSocket.close();
    }
}