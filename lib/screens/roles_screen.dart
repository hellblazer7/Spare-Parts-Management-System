import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class RolesScreen extends StatefulWidget {
  static const String id = 'roles_screen';
  const RolesScreen({Key? key}) : super(key: key);

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(50.0),
            color: Colors.green.shade900,
            child: const Center(
              child: Text(
                'Roles',
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
  final String roleName;
  final int salary;

  const EmployeeBubble({
    Key? key,
    required this.roleName,
    required this.salary,
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
          color: Colors.green,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ImageIcon(
              AssetImage('images/roles.png'),
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
                      'Role Name:' + roleName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Salary: ' + salary.toString(),
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
      stream: _firestore.collection('roles').snapshots(),
      builder: (context, snapshot) {
        List<EmployeeBubble> employeeBubbles = [];
        final employees = snapshot.data?.docs;
        if (employees != null) {
          for (var employee in employees) {
            print(employee.data());
            final rolename = employee.get('role_name');
            final salary = employee.get('salary');
            final employeeBubble = EmployeeBubble(
              salary: salary,
              roleName: rolename,
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
