import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tangrad/components/my_text_field.dart';
import 'package:tangrad/screens/main_screen.dart';
import 'package:tangrad/widgets/global.dart';
import 'package:tangrad/widgets/loading_dialog.dart';
import '../components/button.dart';
import '../components/square_tile.dart';
import '../constants/const.dart';
import '../widgets/error_dialoge.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController prefName = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void signUserIn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  XFile? imageXfile;
  final ImagePicker _picker = ImagePicker();

  String userImageUrl = '';

// GET IMAGE FROM FILE
  Future<void> _getImage() async {
    imageXfile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageXfile;
    });
  }

//final _authService = AuthService();
  int selectedService = -1;

  Future<void> formValiation() async {
    if (imageXfile == null) {
      showDialog(
        context: context,
        builder: (c) {
          return ErroDialog(
            message: 'Please Select Image',
          );
        },
      );
    } else {
      if (passwordController.text == confirmPasswordController.text) {
        if (confirmPasswordController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            emailController.text.isNotEmpty) {
          // START UPLOADING IMAGE
          showDialog(
              context: context,
              builder: (c) {
                return LoadingDialog(
                  message: 'Registering Account',
                );
              });

          // Image Storage to Firebase Storage

          String fileName = DateTime.now().millisecondsSinceEpoch.toString();

          fStorage.Reference reference = fStorage.FirebaseStorage.instance
              .ref()
              .child('users')
              .child(fileName);

          fStorage.UploadTask uploadTask =
              reference.putFile(File(imageXfile!.path));
          // download url
          fStorage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            userImageUrl = url;

            // save info to firestore

            AuthenticateSeller();
          });
        } else {
          showDialog(
            context: context,
            builder: (c) {
              return ErroDialog(
                message: 'Please write the required info for registration',
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (c) {
            return ErroDialog(
              message: 'Hmm, Passwords do not match',
            );
          },
        );
      }
    }
  }

  void AuthenticateSeller() async {
    User? currentUser;

    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (c) {
          return ErroDialog(
            message: error.message.toString(),
          );
        },
      );
    });

    if (currentUser != null) {
      saveDataToFirestore(currentUser!).then((value) {
        Navigator.pop(context);

        // Send user to Home
        Route newRoute = MaterialPageRoute(
          builder: ((context) => const HomeScreen()),
        );
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set({
      'userUID': currentUser.uid,
      'userEmail': currentUser.email,
      'userPhoto': userImageUrl,
      'userStatus': 'approved',
      'firstName': 'null',
      'lastName': 'null',
      'middleName': 'null',
      'userDocuments': [],
      'userServices':
          [], // Maps each ServiceStatus to a Firestore-friendly format
    });

    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString('uid', currentUser.uid);
    await sharedPreferences!.setString('email', currentUser.email.toString());
    await sharedPreferences!.setString('photoUrl', userImageUrl);
    await sharedPreferences!.setStringList('userDocuments', []); //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => _getImage(),
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.20,
                  backgroundColor: Colors.white,
                  backgroundImage: imageXfile == null
                      ? null
                      : FileImage(
                          File(imageXfile!.path),
                        ),
                  child: imageXfile == null
                      ? Icon(
                          Icons.add_photo_alternate,
                          size: MediaQuery.of(context).size.width * 0.20,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ),

              const SizedBox(
                height: 50,
              ),
              // welcome back, you've been missing
              Text(
                'Welcome to tangrad education',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //user name textfield

              MyTextField(
                hintText: 'Email',
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10),
              // password field
              MyTextField(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: confirmPasswordController,
              ),

              const SizedBox(height: 10),
              // forgot password
              //everything centers row set to start maixis aligns to right
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              //Sign in button
              const SizedBox(height: 25),
              MyButton(
                onTap: () {
                  formValiation();
                },
                text: "Sign Up",
              ),
              // or continue with
              const SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'or continue with',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                    imagePath: 'lib/images/google.png',
                  ),
                  SizedBox(width: 25),
                  SquareTile(
                    imagePath: 'lib/images/apple.png',
                  ),
                ],
              ),
              // google + sign in button

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member ?',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register Now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
