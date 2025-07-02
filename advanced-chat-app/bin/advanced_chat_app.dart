import 'dart:io';
import 'package:advanced_chat_app/server.dart';
import 'package:advanced_chat_app/client.dart';

void main() async {
  print('Choose mode:');
  print('1. Run Server');
  print('2. Run Client');
  print('Enter choice (1 or 2):');
  String? choice = stdin.readLineSync()?.trim();

  if (choice == '1') {
    // Run Server
    final server = ChatServer();
    const host = '127.0.0.1';
    const port = 4040;
    await server.start(host, port);
    print('Press Ctrl+C to stop the server');
    await Future.delayed(Duration(days: 365)); // Keep server running
    server.stop();
  } else if (choice == '2') {
    // Run Client
    final client = ChatClient();
    const host = '127.0.0.1';
    const port = 4040;

    print('Enter your username:');
    String? username = stdin.readLineSync()?.trim();
    if (username == null || username.isEmpty) {
      print('Username cannot be empty.');
      return;
    }

    final connected = await client.connect(host, port, username);
    if (!connected) {
      print('Failed to connect to server. Exiting.');
      return;
    }

    print('Type your messages (type "exit" to quit):');
    while (true) {
      String? message = stdin.readLineSync()?.trim();
      if (message == null || message.isEmpty) continue;
      if (message.toLowerCase() == 'exit') {
        client.disconnect();
        break;
      }
      client.sendMessage(message);
    }
  } else {
    print('Invalid choice. Please run again and choose 1 or 2.');
  }
}