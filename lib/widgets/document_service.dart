import 'dart:io';
import 'package:image_picker/image_picker.dart';

class DocumentService {
  final ImagePicker _picker = ImagePicker();

  // Pick a document from the gallery (this can also be extended to pick any type of file)
  Future<File?> pickDocument() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery); // Change to ImageSource.camera for camera
    if (pickedFile != null) {
      return File(
          pickedFile.path); // Return the picked document as a File object
    }
    return null;
  }

  // This function would be implemented to upload the document to your server
  Future<void> uploadDocument(
      File file, String userId, String documentName) async {
    // Logic to upload file, like calling an API
    // Example: use http package to POST file to server
    // This is a placeholder and should be replaced with actual implementation
    print("Uploading document $documentName for user $userId");
  }
}
