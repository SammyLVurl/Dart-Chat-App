import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'message.dart';
import 'storage.dart';

class ChatServer {
  final ChatStorage storage = ChatStorage();
  final List<Socket> clients = [];
  ServerSocket? serverSocket;

  Future<void> start(String host, int port) async {
    try {
      serverSocket = await ServerSocket.bind(host, port);
      print('Server running on $host:$port');
      serverSocket!.listen((client) => _handleClient(client));
    } catch (e) {
      print('Error starting server: $e');
    }
  }

  void _handleClient(Socket client) {
    print('New client connected: ${client.remoteAddress.address}:${client.remotePort}');
    clients.add(client);

    client.listen(
      (data) {
        final message = utf8.decode(data).trim();
        if (message.startsWith('USERNAME:')) {
          client.write(utf8.encode('Username set\n'));
        } else {
          final parts = message.split(': ', );
          if (parts.length == 2) {
            final username = parts[0];
            final content = parts[1];
            final msg = Message(
              username: username,
              content: content,
              timestamp: DateTime.now(),
            );
            storage.saveMessage(msg);
            _broadcastMessage(msg); // Line 32
          }
        }
      },
      onDone: () {
        print('Client disconnected: ${client.remoteAddress.address}:${client.remotePort}');
        clients.remove(client);
        client.close();
      },
      onError: (e) {
        print('Client error: $e');
        clients.remove(client);
        client.close();
      },
    );
  }

  void _broadcastMessage(Message message) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final formattedMessage = '[${formatter.format(message.timestamp)}] ${message.username}: ${message.content}\n';
    for (var client in clients) {
      try {
        client.write(utf8.encode(formattedMessage));
      } catch (e) {
        print('Error broadcasting to client: $e');
      }
    }
  }

  void stop() {
    serverSocket?.close();
    for (var client in clients) {
      client.close();
    }
    clients.clear();
    print('Server stopped.');
  }
}