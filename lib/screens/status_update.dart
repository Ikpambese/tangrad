// import 'package:flutter/material.dart';

// import '../models/service_status.dart';

// class StatusPage extends StatelessWidget {
//   final List<ServiceStatus> statuses;

//   StatusPage({required this.statuses});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Status Updates'),
//       ),
//       body: ListView.builder(
//         itemCount: statuses.length,
//         itemBuilder: (context, index) {
//           final status = statuses[index];
//           return ListTile(
//             title: Text(status.serviceType),
//             subtitle: Text('Status: ${status.status}'),
//             trailing: Text('${status.updatedDate}'),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:tangrad/models/service_status.dart';
// Assuming you have the ServiceStatus model implemented

class StatusPage extends StatelessWidget {
  final List<ServiceStatus> statuses;

  StatusPage({required this.statuses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Updates'),
      ),
      body: ListView.builder(
        itemCount: statuses.length,
        itemBuilder: (context, index) {
          final status = statuses[index];
          return Card(
            child: ListTile(
              title: Text(status.serviceType),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status: ${status.status}'),
                  Text('Updated: ${status.updatedDate}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
