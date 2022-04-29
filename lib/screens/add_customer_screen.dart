import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/roundedbutton.dart';
import '../constants.dart';
import 'customer_screen.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class AddCustomerScreen extends StatefulWidget {
  static const String id = 'add_customer';
  const AddCustomerScreen({Key? key}) : super(key: key);

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  late int customerId;
  late String firstName;
  late String lastName;
  late int phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                'Add Customer',
                style: TextStyle(
                  fontSize: 40.0,
                ),
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                customerId = int.parse(value);
              },
              decoration: kInputFieldDecoration.copyWith(
                hintText: 'CustomerId',
                hintStyle: const TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                firstName = value;
              },
              decoration: kInputFieldDecoration.copyWith(
                hintText: 'First Name',
                hintStyle: const TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                lastName = value;
              },
              decoration: kInputFieldDecoration.copyWith(
                hintText: 'Last Name',
                hintStyle: const TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                phoneNumber = int.parse(value);
              },
              decoration: kInputFieldDecoration.copyWith(
                hintText: 'Phone Number',
                hintStyle: const TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
            RoundedButton(
              onPressed: () async {
                try {
                  _firestore.collection('Customer').add(
                    {
                      'customer_id': customerId,
                      'first_name': firstName,
                      'last_name': lastName,
                      'phone_number ': phoneNumber,
                    },
                  );
                  Navigator.popAndPushNamed(
                    context,
                    CustomerScreen.id,
                  );
                } catch (e) {
                  print(e);
                }
              },
              displayText: 'Add Customer',
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
