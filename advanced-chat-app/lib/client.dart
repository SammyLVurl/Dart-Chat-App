import 'dart:io';
import 'dart:convert';

class ChatClient {
  Socket? socket;
  String username = '';

  Future<bool> connect(String host, int port, String username) async {
    this.username = username;
    try {
      socket = await Socket.connect(host, port);
      print('Connected to server: $host:$port');
      socket!.write('USERNAME: $username\n');
      socket!.listen(
        (data) {
          final message = utf8.decode(data).trim();
          if (message != 'Username set') {
            print(message);
          }
        },
        onDone: () {
          print('Disconnected from server.');
          socket?.close();
          socket = null;
        },
        onError: (e) {
          print('Client error: $e');
          socket?.close();
          socket = null;
        },
      );
      return true;
    } catch (e) {
      print('Error connecting to server: $e');
      return false;
    }
  }

  void sendMessage(String content) {
    if (socket != null) {
      socket!.write('$username: $content\n');
    } else {
      print('Not connected to server.');
    }
  }

  void disconnect() {
    socket?.close();
    socket = null;
    print('Disconnected.');
  }
}