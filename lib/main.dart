import 'package:flutter/material.dart';
import 'Home/homepage.dart';
import 'homepage.dart'; // Import your HomePage
import 'Authentication/register.dart'; // Import your RegisterScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Corrected super.key to Key? key

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple, // Changed seedColor to primarySwatch
        ),
        useMaterial3: true,
      ),
      initialRoute: '/', // Define initialRoute
      routes: {
        '/': (context) => HomePage(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
