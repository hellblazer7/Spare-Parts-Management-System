import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class CustomerScreen extends StatefulWidget {
  static const String id = 'customer_screen';
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(50.0),
            color: Colors.blue.shade900,
            child: const Center(
              child: Text(
                'Customers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                ),
              ),
            ),
          ),
          const CustomerStream(),
        ],
      ),
    );
  }
}

class CustomerBubble extends StatelessWidget {
  final int custid;
  final String firstName;
  final String lastName;
  final int phone;

  const CustomerBubble(
      {Key? key,
      required this.custid,
      required this.firstName,
      required this.lastName,
      required this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(
          20.0,
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ImageIcon(
              AssetImage('images/customer.png'),
              color: Colors.white,
              size: 55.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name:' + firstName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      lastName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Phone: ' + phone.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerStream extends StatelessWidget {
  const CustomerStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Customer').snapshots(),
      builder: (context, snapshot) {
        List<CustomerBubble> customerBubbles = [];
        final customers = snapshot.data?.docs;
        if (customers != null) {
          for (var customer in customers) {
            print(customer.data());
            final customerid = customer.get('customer_id');
            final firstname = customer.get('first_name');
            final lastname = customer.get('last_name');
            final phone = customer.get('phone_number ');
            final customerBubble = CustomerBubble(
              custid: customerid,
              firstName: firstname,
              lastName: lastname,
              phone: phone,
            );
            customerBubbles.add(customerBubble);
          }
        }

        return Expanded(
          child: ListView(
            children: customerBubbles,
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
          ),
        );
      },
    );
  }
}
