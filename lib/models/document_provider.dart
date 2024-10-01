import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tangrad/models/document_model.dart';

class DocumentProvider extends ChangeNotifier {
  final List<Document> _documents = [];

  // Get documents list
  List<Document> get documents => _documents;

  // Fetch documents from Firebase Firestore
  Future<void> fetchDocuments() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('documents').get();

    // Clear previous list and repopulate
    _documents.clear();

    for (var doc in snapshot.docs) {
      _documents.add(
          Document.fromFirestore(doc.data() as Map<String, dynamic>, doc.id));
    }

    notifyListeners();
  }
}
