import 'dart:io';
import 'package:advanced_chat_app/client.dart';

void main() async {
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
}