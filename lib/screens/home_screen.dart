import 'package:flutter/material.dart';
import 'package:spare_parts_management_system/components/gototablebutton.dart';
import 'package:spare_parts_management_system/components/roundedbutton.dart';
import 'package:spare_parts_management_system/screens/add_customer_screen.dart';
import 'package:spare_parts_management_system/screens/customer_screen.dart';
import 'package:spare_parts_management_system/screens/employee_screen.dart';
import 'package:spare_parts_management_system/screens/roles_screen.dart';
import 'package:spare_parts_management_system/screens/spare_parts_screen.dart';
import 'package:spare_parts_management_system/screens/supplier_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Center(
                    child: Text(
                      'View Tables',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                      ),
                    ),
                  ),
                  RoundedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddCustomerScreen.id);
                      },
                      displayText: 'Add',
                      color: Colors.black),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GoToTableButton(
                  theme: Colors.blue,
                  tableImage: 'images/customer.png',
                  tableName: 'Customer Table',
                  onPressed: () {
                    Navigator.pushNamed(context, CustomerScreen.id);
                  },
                ),
                GoToTableButton(
                  theme: Colors.purple,
                  tableImage: 'images/employee.png',
                  tableName: 'Employee Table',
                  onPressed: () {
                    Navigator.pushNamed(context, EmployeeScreen.id);
                  },
                ),
                GoToTableButton(
                  theme: Colors.green,
                  tableImage: 'images/roles.png',
                  tableName: 'Roles Table',
                  onPressed: () {
                    Navigator.pushNamed(context, RolesScreen.id);
                  },
                ),
                GoToTableButton(
                  theme: Colors.pink,
                  tableImage: 'images/supplier.png',
                  tableName: 'Supplier Table',
                  onPressed: () {
                    Navigator.pushNamed(context, SupplierScreen.id);
                  },
                ),
                GoToTableButton(
                  theme: Colors.black,
                  tableImage: 'images/spare_parts.png',
                  tableName: 'Spare Parts Table',
                  onPressed: () {
                    Navigator.pushNamed(context, SparePartsScreen.id);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
