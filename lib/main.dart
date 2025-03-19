import 'package:agentshipr/login_screen.dart';
import 'package:agentshipr/navigation_menu.dart';
import 'package:agentshipr/screens/orders/order_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agent Shipr',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login', // Start with the LoginScreen
      routes: {
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => NavigationMenu(),
        '/orderPage': (context) => OrdersPage(),
      },
    );
  }
}
