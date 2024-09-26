class Message {
  String id;
  String senderId;
  String receiverId;
  String message;
  DateTime timestamp;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });
}

class MessageService {
  // Add function to fetch messages for a user
  // Add function to send a message from admin to user
}
