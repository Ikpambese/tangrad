import 'package:flutter/material.dart';
import 'package:tangrad/models/user_model.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}'),
            Text('Email: ${user.email}'),
            Text('Phone: ${user.phone}'),
            SizedBox(height: 20),
            Text('Documents:', style: TextStyle(fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              itemCount: user.documents.length,
              itemBuilder: (context, index) {
                final document = user.documents[index];
                return ListTile(
                  title: Text(document.name),
                  subtitle: Text('Uploaded: ${document.uploadedDate}'),
                  onTap: () {
                    // Open document URL in browser or viewer
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
