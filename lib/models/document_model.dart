// Document Model
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
}
