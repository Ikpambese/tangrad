// // Document Model
// class Document {
//   String id;
//   String userId;
//   String name;
//   String url; // URL for uploaded document
//   DateTime uploadedDate;

//   Document({
//     required this.id,
//     required this.userId,
//     required this.name,
//     required this.url,
//     required this.uploadedDate,
//   });
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class Document {
  String id;
  String userId;
  String name;
  String url; // URL for uploaded document
  DateTime uploadedDate;

  Document({
    required this.id,
    required this.userId,
    required this.name,
    required this.url,
    required this.uploadedDate,
  });

  // Factory method to create Document from Firebase snapshot
  factory Document.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Document(
      id: documentId,
      userId: data['userId'],
      name: data['name'],
      url: data['url'],
      uploadedDate: (data['uploadedDate'] as Timestamp).toDate(),
    );
  }
}
