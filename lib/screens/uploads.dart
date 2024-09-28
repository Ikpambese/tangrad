import 'package:flutter/material.dart';
import 'package:tangrad/constants/const.dart';
import 'package:tangrad/widgets/slider_button.dart';
import 'dart:io';
import '../widgets/document_service.dart';

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
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hi Benjamin\nKindly ',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: 'Upload',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white, // Set green color for 'positive'
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Your Documents.',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              _document == null
                  ? Text(
                      'No document selected.',
                      style: TextStyle(color: errorColor),
                    )
                  : Text('Document selected: ${_document!.path}'),
              Column(
                children: [
                  IconButton(
                    onPressed: () async {
                      final file = await _documentService.pickDocument();
                      setState(() {
                        _document = file;
                      });
                    },
                    tooltip: 'You are about to select a document',
                    icon: Icon(
                      Icons.document_scanner_rounded,
                      size: 40,
                      color: backgroundColor,
                    ),
                  ),
                  Text(
                    'Tap to select a document',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: backgroundColor,
                    ),
                  )
                ],
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     if (_document != null) {
              //       _documentService.uploadDocument(
              //         _document!,
              //         'userId',
              //         'Document Name',
              //       );
              //       // Show success message or navigate
              //     }
              //   },
              //   child: const Text('Upload Document'),
              // ),
              SizedBox(height: 50),
              SliderButto()
            ],
          ),
        ),
      ),
    );
  }
}
