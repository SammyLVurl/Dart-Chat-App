import 'package:advanced_chat_app/server.dart';

void main() async {
  final server = ChatServer();
  const host = '127.0.0.1';
  const port = 4040;
  await server.start(host, port);

  // Keep server running until interrupted
  await Future.delayed(Duration(days: 365)); // Simulate long-running server
  server.stop();
}