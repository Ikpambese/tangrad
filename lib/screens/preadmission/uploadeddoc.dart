// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tangrad/components/coffee_tile.dart';
// import 'package:tangrad/constants/const.dart';
// import 'package:tangrad/models/coffee.dart';
// import '../../models/shop.dart';

// class UploadedDocumentsPage extends StatefulWidget {
//   const UploadedDocumentsPage({super.key});

//   @override
//   State<UploadedDocumentsPage> createState() => _UploadedDocumentsPageState();
// }

// class _UploadedDocumentsPageState extends State<UploadedDocumentsPage> {
//   void addTocart(Coffee coffee) {
//     Provider.of<Coffeeshop>(context, listen: false).addItemsToCart(coffee);
//     showDialog(
//       context: (context),
//       builder: (context) => const AlertDialog(
//         title: Text('Successfully added to documents'),
//         icon: Icon(Icons.person),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Coffeeshop>(
//         builder: (context, value, child) => SafeArea(
//               child: Scaffold(
//                 backgroundColor: backgroundColor,
//                 body: Padding(
//                   padding: const EdgeInsets.all(25),
//                   child: Column(
//                     children: [
//                       //heading
//                       const Text(
//                         'How would you like your coffee ?',
//                         style: TextStyle(
//                           fontSize: 25,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 25,
//                       ),

//                       // list of cofffeev
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: value.coffeeshop.length,
//                           itemBuilder: (context, index) {
//                             //Get individual  coffee
//                             Coffee eachCoffee = value.coffeeshop[index];
//                             return CoffeeTile(
//                               icon: const Icon(Icons.add),
//                               coffee: eachCoffee,
//                               onTap: () => addTocart(eachCoffee),
//                             );
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/document_provider.dart'; // To open URLs (PDFs)

class UploadedDocumentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the provider
    final documentProvider = Provider.of<DocumentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Documents')),
      body: FutureBuilder(
        future: documentProvider.fetchDocuments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (documentProvider.documents.isEmpty) {
            return Center(child: Text('No documents found'));
          }

          return ListView.builder(
            itemCount: documentProvider.documents.length,
            itemBuilder: (context, index) {
              final document = documentProvider.documents[index];
              return ListTile(
                title: Text(document.name),
                subtitle: Text('Uploaded on ${document.uploadedDate}'),
                trailing: IconButton(
                  icon: Icon(Icons.picture_as_pdf),
                  onPressed: () async {
                    if (await canLaunch(document.url)) {
                      await launch(document.url);
                    } else {
                      throw 'Could not open PDF at ${document.url}';
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
