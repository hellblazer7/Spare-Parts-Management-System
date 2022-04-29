import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class SupplierScreen extends StatefulWidget {
  static const String id = 'supplier_screen';
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(50.0),
            color: Colors.red.shade900,
            child: const Center(
              child: Text(
                'Suppliers',
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
  final String provinceName;
  final String cityName;
  final String supplierName;

  const EmployeeBubble({
    Key? key,
    required this.provinceName,
    required this.supplierName,
    required this.cityName,
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
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ImageIcon(
              AssetImage('images/supplier.png'),
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
                      'Location:' + provinceName + ',',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      cityName,
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
                      'Supplier: ' + supplierName,
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
      stream: _firestore.collection('supplier').snapshots(),
      builder: (context, snapshot) {
        List<EmployeeBubble> employeeBubbles = [];
        final employees = snapshot.data?.docs;
        if (employees != null) {
          for (var employee in employees) {
            print(employee.data());
            final cityname = employee.get('province');
            final provincename = employee.get('city');
            final suppliername = employee.get('supplier_name');
            final employeeBubble = EmployeeBubble(
              cityName: cityname,
              provinceName: provincename,
              supplierName: suppliername,
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
