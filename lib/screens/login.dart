import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tangrad/components/my_text_field.dart';
import 'package:tangrad/screens/main_screen.dart';
import 'package:tangrad/screens/preadmission/pre_addmission.dart';
import 'package:tangrad/screens/sign_up.dart';
import 'package:tangrad/widgets/global.dart';
import 'package:tangrad/widgets/loading_dialog.dart';
import '../components/button.dart';
import '../components/square_tile.dart';
import '../constants/const.dart';
import '../widgets/error_dialoge.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  formValidation() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      // Login

      loginNow();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErroDialog(
              message: 'Email or password is empty',
            );
          });
    }
  }

  //LOGIN FUNCTION

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingDialog(
            message: 'Checking credentials',
          );
        });

    User? currentUser;

    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
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
          });
    });

    if (currentUser != null) {
      readDataAndSaveLocally(currentUser!);
    }
  }

  Future readDataAndSaveLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        if (snapshot.data()!['userStatus'] == 'approved') {
          await sharedPreferences!.setString('uid', currentUser.uid);
          await sharedPreferences!
              .setString('email', snapshot.data()!['userEmail']);

          await sharedPreferences!
              .setString('photoUrl', snapshot.data()!['userAvatarUrl']);

          List<String> userCartList =
              snapshot.data()!['userCart'].cast<String>(); // We had
          //type 'List<dynamic>' is not a subtype of type 'List<String>' solved by adding .cast^
          await sharedPreferences!.setStringList('userCart', userCartList);
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const HomeScreen()));
        } else {
          firebaseAuth.signOut();
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg:
                  'Admin has blocked your account \n\n Mail Here :admin@lunchbox.com');
        }
      } else {
        firebaseAuth.signOut();
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const SignUpScreen()));
        showDialog(
            context: context,
            builder: (c) {
              return ErroDialog(
                message: 'No records found',
              );
            });
      }
    });
  }

  void signUserIn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreadmissionPage(),
      ),
    );
  }

//final _authService = AuthService();
  int selectedService = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'lib/images/tangrad.jpeg',
                  height: 100,
                ),
              ),

              const SizedBox(
                height: 50,
              ),
              // welcome back, you've been missing
              Text(
                'Welcome back you\'ve been missed',
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
                hintText: 'User name',
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10),
              // password field
              MyTextField(
                hintText: 'User name',
                obscureText: true,
                controller: passwordController,
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
                    formValidation();
                  },
                  text: "Sign In"),
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
