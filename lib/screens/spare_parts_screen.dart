import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class SparePartsScreen extends StatefulWidget {
  static const String id = 'spare_parts_screen';
  const SparePartsScreen({Key? key}) : super(key: key);

  @override
  State<SparePartsScreen> createState() => _SparePartsScreenState();
}

class _SparePartsScreenState extends State<SparePartsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(50.0),
            color: Colors.black,
            child: const Center(
              child: Text(
                'Spare Parts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                ),
              ),
            ),
          ),
          const EmployeeStream(),
        ],
      ),
    );
  }
}

class EmployeeBubble extends StatelessWidget {
  final String category;
  final String name;
  final int price;

  const EmployeeBubble({
    Key? key,
    required this.category,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(
          20.0,
        ),
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ImageIcon(
              AssetImage('images/spare_parts.png'),
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
                      'Name,Category:' + name + ',',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Price: ' + price.toString(),
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

class EmployeeStream extends StatelessWidget {
  const EmployeeStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('spare_parts').snapshots(),
      builder: (context, snapshot) {
        List<EmployeeBubble> employeeBubbles = [];
        final employees = snapshot.data?.docs;
        if (employees != null) {
          for (var employee in employees) {
            print(employee.data());
            final name = employee.get('name');
            final category = employee.get('category');
            final price = employee.get('price');
            final employeeBubble = EmployeeBubble(
              name: name,
              category: category,
              price: price,
            );
            employeeBubbles.add(employeeBubble);
          }
        }

        return Expanded(
          child: ListView(
            children: employeeBubbles,
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
