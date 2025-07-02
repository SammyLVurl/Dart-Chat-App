import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'message.dart';

class ChatStorage {
  final String filePath = path.join(Directory.current.path, 'chat_history.json');

  Future<List<Message>> loadMessages() async {
    final file = File(filePath);
    if (!await file.exists()) return [];
    try {
      final jsonString = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Message.fromJson(json)).toList();
    } catch (e) {
      print('Error loading chat history: $e');
      return [];
    }
  }

  Future<void> saveMessage(Message message) async {
    final file = File(filePath);
    List<Message> messages = await loadMessages();
    messages.add(message);
    try {
      final jsonString = jsonEncode(messages.map((m) => m.toJson()).toList());
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error saving message: $e');
    }
  }
}