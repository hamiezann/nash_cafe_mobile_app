import 'package:flutter/material.dart';
import  'Home/homepage.dart';
import 'Authentication/register.dart'; // Import your RegisterScreen
import 'Authentication/login.dart'; // Import your LoginScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/', // Define initialRoute
      routes: {
        '/': (context) => HomePage(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginPage(), // Adding login route
      },
    );
  }
}
