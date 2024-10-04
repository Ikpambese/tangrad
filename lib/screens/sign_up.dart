import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  XFile? imageXfile;
  final ImagePicker _picker = ImagePicker();

  String userImageUrl = '';
  SharedPreferences? sharedPreferences;

  // GET IMAGE FROM FILE OR CAMERA
  Future<void> _getImage() async {
    imageXfile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageXfile = imageXfile; // Update the state correctly
    });
  }

  Future<void> formValidation() async {
    if (imageXfile == null) {
      showDialog(
        context: context,
        builder: (c) {
          return ErroDialog(
            message: 'Please Select Image',
          );
        },
      );
    } else if (passwordController.text != confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (c) {
          return ErroDialog(
            message: 'Hmm, Passwords do not match',
          );
        },
      );
    } else if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (c) {
          return ErroDialog(
            message: 'Please provide all required information',
          );
        },
      );
    } else {
      try {
        // START UPLOADING IMAGE
        showDialog(
          context: context,
          builder: (c) {
            return LoadingDialog(
              message: 'Registering Account',
            );
          },
        );

        //Image Storage to Firebase Storage
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        firebase_storage.Reference reference = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('users')
            .child(fileName);

        firebase_storage.UploadTask uploadTask =
            reference.putFile(File(imageXfile!.path));

        // Download URL
        await uploadTask.whenComplete(() async {
          userImageUrl = await reference.getDownloadURL();

          // Save info to Firestore and authenticate user
          authenticateUser();
        });
      } catch (error) {
        Navigator.pop(context); // Close loading dialog if any error occurs

        showDialog(
          context: context,
          builder: (c) {
            return ErroDialog(
              message: 'An error occurred: ${error.toString()}',
            );
          },
        );

        rethrow;
      }
    }
  }

  void authenticateUser() async {
    User? currentUser;

    try {
      (await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ));
      currentUser = await firebaseAuth.currentUser;
      if (currentUser != null) {
        print(currentUser.uid);
        print(currentUser.email);
        print(currentUser.displayName);
        await saveDataToFirestore(currentUser).then((value) {
          Navigator.pop(context); // Close loading dialog

          // Send user to Home
          Route newRoute = MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          );
          Navigator.pushReplacement(context, newRoute);
        });
      }
    } on FirebaseAuthException catch (e) {
      // Close loading dialog
      Navigator.pop(context);

      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is invalid.';
      } else {
        errorMessage = 'An unknown error occurred: ${e.message}';
      }

      showDialog(
        context: context,
        builder: (c) {
          return ErroDialog(
            message: errorMessage,
          );
        },
      );
    } catch (error) {
      // Generic error handling, just in case it's not a Firebase-specific issue
      Navigator.pop(context); // Close loading dialog

      showDialog(
        context: context,
        builder: (c) {
          return ErroDialog(
            message: error.toString(),
          );
        },
      );
      rethrow;
    }
  }

  Future<void> saveDataToFirestore(User currentUser) async {
    try {
      // Save user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .set({
        'userUID': currentUser.uid,
        'userEmail': currentUser.email,
        'userPhoto': userImageUrl,
        'userStatus': 'approved',
        'firstName': 'null',
        'lastName': 'null',
        'middleName': 'null',
        'userDocuments': [],
        'userServices': [],
      });

      // Save user data to SharedPreferences
      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences!.setString('uid', currentUser.uid);
      await sharedPreferences!.setString('email', currentUser.email.toString());
      await sharedPreferences!.setString('photoUrl', userImageUrl);
      await sharedPreferences!.setStringList('userDocuments', []);
    } catch (error) {
      // Handle any errors that occur during the process
      showDialog(
        context: context,
        builder: (c) {
          return ErroDialog(
            message: 'An error occurred while saving data: ${error.toString()}',
          );
        },
      );
    }
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

              const SizedBox(height: 50),
              Text(
                'Welcome to tangrad education',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),

              // Email text field
              MyTextField(
                hintText: 'Email',
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10),

              // Password text field
              MyTextField(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),

              // Confirm Password text field
              MyTextField(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: confirmPasswordController,
              ),

              const SizedBox(height: 10),
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
              const SizedBox(height: 25),

              // Sign Up button
              MyButton(
                onTap: () {
                  formValidation();
                },
                text: "Sign Up",
              ),
              const SizedBox(height: 50),

              // Divider for "or continue with"
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
              const SizedBox(height: 50),

              // Social media login buttons
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
              const SizedBox(height: 50),

              // Already a member? Register Now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
