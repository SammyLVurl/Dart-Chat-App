import 'dart:convert';
import 'package:intl/intl.dart';

class Message {
  final String username;
  final String content;
  final DateTime timestamp;

  Message({
    required this.username,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'content': content,
        'timestamp': DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp),
      };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        username: json['username'],
        content: json['content'],
        timestamp: DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['timestamp']),
      );
}