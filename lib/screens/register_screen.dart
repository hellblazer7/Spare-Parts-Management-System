import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spare_parts_management_system/components/roundedbutton.dart';
import 'package:spare_parts_management_system/screens/login_screen.dart';

import '../constants.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Colors.red,
              child: const Image(
                image: AssetImage(
                  'images/spare_parts_icon.png',
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
              ),
              child: const Center(
                child: Text(
                  'Spare Parts Management',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kInputFieldDecoration.copyWith(
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kInputFieldDecoration.copyWith(
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70.0,
                  ),
                  RoundedButton(
                    onPressed: () async {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        Navigator.popAndPushNamed(
                          context,
                          HomeScreen.id,
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    displayText: 'Register',
                    color: Colors.red.shade400,
                  ),
                  RoundedButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(
                        context,
                        LoginScreen.id,
                      );
                    },
                    displayText: 'Already a User? Login',
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
