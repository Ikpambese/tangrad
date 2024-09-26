// User Model
import 'document_model.dart';
import 'service_status.dart';

class User {
  String id;
  String name;
  String email;
  String phone;
  String password;
  List<Document> documents;
  List<ServiceStatus> serviceStatuses;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.documents,
    required this.serviceStatuses,
  });
}
