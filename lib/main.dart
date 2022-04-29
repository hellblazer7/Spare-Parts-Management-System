import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spare_parts_management_system/screens/add_customer_screen.dart';
import 'package:spare_parts_management_system/screens/customer_screen.dart';
import 'package:spare_parts_management_system/screens/employee_screen.dart';
import 'package:spare_parts_management_system/screens/home_screen.dart';
import 'package:spare_parts_management_system/screens/login_screen.dart';
import 'package:spare_parts_management_system/screens/register_screen.dart';
import 'package:spare_parts_management_system/screens/roles_screen.dart';
import 'package:spare_parts_management_system/screens/spare_parts_screen.dart';
import 'package:spare_parts_management_system/screens/supplier_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RegisterScreen.id,
      routes: {
        RegisterScreen.id: (context) => const RegisterScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        CustomerScreen.id: (context) => const CustomerScreen(),
        EmployeeScreen.id: (context) => const EmployeeScreen(),
        RolesScreen.id: (context) => const RolesScreen(),
        SupplierScreen.id: (context) => const SupplierScreen(),
        SparePartsScreen.id: (context) => const SparePartsScreen(),
        AddCustomerScreen.id: (context) => const AddCustomerScreen(),
      },
    );
  }
}
