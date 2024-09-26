import 'package:flutter/material.dart';
import 'package:tangrad/constants/const.dart';
import 'package:tangrad/screens/document_upload.dart';
import 'package:tangrad/screens/uploads.dart';
import 'package:tangrad/services/service_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Service> services = [
    Service('Uploads', 'lib/images/upload.png'),
    Service('Pre admission', 'lib/images/preadd.png'),
    Service('Post admission', 'lib/images/postadd.png'),
    Service('Visa assist', 'lib/images/visa.png'),
    Service('Update', 'lib/images/update.png'),
    Service('Profile', 'lib/images/profile.png'),
    Service('Edit', 'lib/images/settings.png'),
  ];

  int selectedService = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          elevation: 0,
          actions: const [
            CircleAvatar(
              backgroundImage: AssetImage('assets/imgs/church.png'),
            ),
            SizedBox(width: 15)
          ],
        ),
        backgroundColor: secondaryColor,
        floatingActionButton: selectedService >= 0
            ? FloatingActionButton(
                foregroundColor: buttonPrimaryColor,
                onPressed: () {
                  if (selectedService == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadPdfScreen(),
                      ),
                    );
                  } else if (selectedService == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadPdfScreen(),
                      ),
                    );
                  } else if (selectedService == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadDocumentPage(),
                      ),
                    );
                  } else if (selectedService == 3) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const RegistrationPage(),
                    //   ),
                    // );
                  }
                },
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              )
            : null,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 120.0, right: 20.0, left: 20.0),
                  // child: Text(
                  //   'Hi Benjamin\nFeeling positive ?',
                  //   style: TextStyle(
                  //     fontSize: 40,
                  //     color: Colors.grey.shade900,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),

                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hi Benjamin\nFeeling ',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: 'positive',
                          style: TextStyle(
                            fontSize: 40,
                            color:
                                Colors.white, // Set green color for 'positive'
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' ?',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 20.0,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: services.length,
                        itemBuilder: (BuildContext context, int index) {
                          return serviceContainer(services[index].imageURL,
                              services[index].name, index);
                        }),
                  ),
                ]),
          ),
        ));
  }

  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedService == index) {
            selectedService = -1;
          } else {
            selectedService = index;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: selectedService == index
              ? Colors.blue.shade50
              : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index
                ? Color.fromRGBO(45, 161, 13, 1)
                : const Color.fromARGB(255, 13, 71, 161).withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(image, height: 80),
              const SizedBox(
                height: 20,
              ),
              Text(
                name,
                style: const TextStyle(fontSize: 20),
              )
            ]),
      ),
    );
  }
}
