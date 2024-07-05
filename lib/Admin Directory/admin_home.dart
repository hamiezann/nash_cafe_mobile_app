import 'package:flutter/material.dart';
import 'package:itt632_nashcafe/Admin%20Directory/Product/menuList.dart';
import 'package:itt632_nashcafe/Home/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Authentication/login.dart';

class AdminHomePage extends StatelessWidget {

  Future<void> _logout(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('userId');
      await prefs.remove('role');
      await prefs.remove('isLoggedIn');

      // Print statements for debugging
      print('Logout successful');

      // Navigate to splash screen
      Navigator.pushReplacementNamed(context, '/splashscreen');
    } catch (e) {
      print('Logout failed: $e');
      // Handle any errors or exceptions here
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Logout Failed'),
          content: Text('An error occurred during logout. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF071952),
        foregroundColor: Colors.white,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Colors.lightBlue, Colors.red, Colors.white],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //   ),
        // ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Handle menu button press
          },
        ),
        actions: [
          IconButton(
            // icon: Icon(Icons.account_circle),
            icon: Icon(Icons.logout_rounded),
            onPressed: () {
              _logout(context);
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Color(0xFF071952),
            height: 120,
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello Admin',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                "Let's satisfy another customer today !",
                style: TextStyle(fontSize: 16, color: Colors.white60),
              ),
            ],
          ),),
          Container(
            margin: EdgeInsets.only(top: 90),
            decoration: BoxDecoration(
              // color: Color(0xFFFCF3CF),
                gradient: LinearGradient(
                  colors: [Colors.lightBlue, Colors.red, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),// Adjust the top margin to overlap with the top section
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30), // Adjust the height to add spacing below the search bar
                    // Text(
                    //   "Let's find out a perfect workspace for you",
                    //   style: TextStyle(fontSize: 16, color: Colors.black54),
                    // ),
                    SizedBox(height: 45),
                    _buildCategoryIcons(context),
                    SizedBox(height: 20),
                    Text(
                      'Recommended for you',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    _buildRecommendedList(),
                    SizedBox(height: 230),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 70, // Adjust the top position to overlap the search bar on both sections
            left: 16,
            right: 16,
            child: _buildSearchBar(),  //search bar
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.black54),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search here...',
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.qr_code_scanner, color: Colors.black54),
        ],
      ),
    );
  }

  Widget _buildCategoryIcons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCategoryIcon(context, Icons.restaurant, 'Menu', AdminMenuList()),
        _buildCategoryIcon(context, Icons.add_chart_outlined, 'Order',  AdminMenuList()),
        _buildCategoryIcon(context, Icons.menu_book_outlined, 'Payment',  AdminMenuList()),
        _buildCategoryIcon(context, Icons.star_half_outlined, 'Rating',  AdminMenuList()),
      ],
    );
  }

  Widget _buildCategoryIcon(BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            child: Icon(icon, size: 30, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildRecommendedList() {
    return Column(
      children: [
        _buildRecommendedItem('Digital Desk Coworking', '3329 White Lane, Georgia', 'Rs. 5,890/day'),
        SizedBox(height: 10),
        _buildRecommendedItem('Renuin Studio', 'Kasardevi, Uttarakhand', 'Rs. 7,890/day'),
      ],
    );
  }

  Widget _buildRecommendedItem(String title, String subtitle, String price) {
    return Card(
      child: ListTile(
        leading: Image.network('https://via.placeholder.com/100'), // Replace with actual image
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(price, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
