import 'package:flutter/material.dart';

import '../models/message.dart';

class MessagesPage extends StatelessWidget {
  final List<Message> messages;

  MessagesPage({required this.messages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return ListTile(
            title: Text('From: ${message.senderId}'),
            subtitle: Text(message.message),
            trailing: Text('${message.timestamp}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement send message logic
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
