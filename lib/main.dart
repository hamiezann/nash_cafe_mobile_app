import 'package:flutter/material.dart';
import 'package:itt632_nashcafe/Admin%20Directory/Order/orderList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:itt632_nashcafe/Admin%20Directory/admin_home.dart';
import 'Customer Directory/customer_home.dart';
import 'Home/homepage.dart';
import 'Authentication/register.dart';
import 'Authentication/login.dart';
import 'package:itt632_nashcafe/Configuration/networkConfig.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool isAdmin = prefs.getString('role') == 'admin';

  String initialRoute = isLoggedIn ? (isAdmin ? '/admin-home' : '/customer-home') : '/splashscreen';

  runApp(MyApp(initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp(this.initialRoute, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nash Cafe Mobile App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.cyan,
        ),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      routes: {
        '/splashscreen': (context) => HomePage(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginPage(),
        '/admin-home': (context) => AdminHomePage(),
        '/customer-home': (context) => CustomerHomePage(),
        '/order-page': (context) => OrdersPage(),
      },
    );
  }
}
