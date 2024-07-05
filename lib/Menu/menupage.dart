import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Configuration/networkConfig.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String selectedCategory = 'Main Course'; // Default category
  List<dynamic> menuItems = []; // List to store fetched menu items

  @override
  void initState() {
    super.initState();
    fetchMenuItems();
  }

  Future<void> fetchMenuItems() async {
    // Replace with your Laravel backend URL
    var url = Uri.parse('http://${Config.apiUrl}/product-list');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          menuItems = jsonDecode(response.body);
        });
      } else {
        print('Failed to fetch menu items');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: Text('Menu'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/logo.png'), // Add your logo asset here
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search burger, beverage, etc.',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'NASH CAFE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Implement scroll function
                  },
                  child: Text('>>'),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryButton(
                    category: 'Main Course',
                    onPressed: () => selectCategory('Main Course')),
                CategoryButton(
                    category: 'Appetizers',
                    onPressed: () => selectCategory('Appetizers')),
                CategoryButton(
                    category: 'Desserts',
                    onPressed: () => selectCategory('Desserts')),
                CategoryButton(
                    category: 'Beverages',
                    onPressed: () => selectCategory('Beverages')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (BuildContext context, int index) {
                return MenuItem(
                  imageUrl: menuItems[index]['image'],
                  title: menuItems[index]['product_name'],
                  description: menuItems[index]['description'],
                  price: '\$${menuItems[index]['price']}',
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String category;
  final VoidCallback onPressed;

  const CategoryButton({required this.category, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(category),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;

  const MenuItem({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(imageUrl), // Load image from network URL
        title: Text(title),
        subtitle: Text(description),
        trailing: Text(price),
      ),
    );
  }
}
