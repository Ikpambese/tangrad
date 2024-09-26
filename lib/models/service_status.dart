// Service Status Model
class ServiceStatus {
  String id;
  String userId;
  String serviceType; // e.g., Pre-admission, Post-admission, Visa
  String status; // e.g., Pending, Approved, Rejected
  DateTime updatedDate;

  ServiceStatus({
    required this.id,
    required this.userId,
    required this.serviceType,
    required this.status,
    required this.updatedDate,
  });
}
