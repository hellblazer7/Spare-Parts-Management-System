import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class EmployeeScreen extends StatefulWidget {
  static const String id = 'employee_screen';
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(50.0),
            color: Colors.purple.shade900,
            child: const Center(
              child: Text(
                'Employees',
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
  final String firstName;
  final String lastName;
  final String gender;

  const EmployeeBubble({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.gender,
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
          color: Colors.purpleAccent,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ImageIcon(
              AssetImage('images/employee.png'),
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
                      'Gender: ' + gender,
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
      stream: _firestore.collection('employees').snapshots(),
      builder: (context, snapshot) {
        List<EmployeeBubble> employeeBubbles = [];
        final employees = snapshot.data?.docs;
        if (employees != null) {
          for (var employee in employees) {
            print(employee.data());
            final firstname = employee.get('f_name');
            final lastname = employee.get('l_name');
            final gender = employee.get('gender');
            final employeeBubble = EmployeeBubble(
              firstName: firstname,
              lastName: lastname,
              gender: gender,
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
