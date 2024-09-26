import 'package:flutter/material.dart';
import 'dart:io';

import '../services/document_service.dart';

class UploadDocumentPage extends StatefulWidget {
  @override
  _UploadDocumentPageState createState() => _UploadDocumentPageState();
}

class _UploadDocumentPageState extends State<UploadDocumentPage> {
  final DocumentService _documentService = DocumentService();
  File? _document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Document'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _document == null
                ? Text('No document selected.')
                : Text('Document selected: ${_document!.path}'),
            ElevatedButton(
              onPressed: () async {
                final file = await _documentService.pickDocument();
                setState(() {
                  _document = file;
                });
              },
              child: Text('Pick Document'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_document != null) {
                  _documentService.uploadDocument(
                      _document!, 'userId', 'Document Name');
                  // Show success message or navigate
                }
              },
              child: Text('Upload Document'),
            ),
          ],
        ),
      ),
    );
  }
}
