import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itt632_nashcafe/Admin%20Directory/Product/addProduct.dart';
import 'package:itt632_nashcafe/Admin%20Directory/Product/editProduct.dart';
import 'package:itt632_nashcafe/Configuration/networkConfig.dart';
class AdminMenuList extends StatefulWidget {
  const AdminMenuList({Key? key}) : super(key: key);

  @override
  State<AdminMenuList> createState() => _AdminMenuListState();
}

class _AdminMenuListState extends State<AdminMenuList> {
  List<dynamic> productList = [];

  Future<void> _menuList() async {
    final response = await http.get(

      Uri.parse('${Config.apiUrl}/product-list'),
    );

    if (response.statusCode == 200) {
      setState(() {
        productList = jsonDecode(response.body);
      });
    } else {
      print('Failed to load products: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load products. Please try again later.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _deleteProduct(int productId) async {
    final response = await http.delete(
      Uri.parse('${Config.apiUrl}/delete-product/$productId'),
    );

    if (response.statusCode == 200) {
      setState(() {
        productList.removeWhere((product) => product['id'] == productId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product deleted successfully.'),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      print('Failed to delete product: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete product. Please try again later.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _showDeleteConfirmationDialog(int productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this product?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteProduct(productId);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _menuList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF071952),
        foregroundColor: Colors.white,
        title: Text('Menu'),
        actions: [
          IconButton(
            onPressed: () {
              print('Add New Product');
              // Implement functionality to add a new product
            },
            icon: Icon(Icons.add),
            tooltip: 'Add Product',
          ),
          IconButton(
            icon: Icon(Icons.category),
            onPressed: () {
              print('Add New Category');
              // Implement functionality to add a new category
            },
            tooltip: 'Add Category',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.red, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 16.0), // Space above the buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CreateProductPage()), // Replace with your actual LoginPage widget
                    );
                    // print('Button 1 pressed');
                  },
                  child: Text('Add New Product'),
                ),
                SizedBox(width: 16.0), // Space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => EditProductPage()),
                    // );
                    print('Button 2 pressed');
                  },
                  child: Text('Add New Category'),
                ),
              ],
            ),
            SizedBox(height: 16.0), // Space below the buttons
            Expanded(
              child: productList.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  var product = productList[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        print('Product tapped: ${product['product_name']}');
                        // Navigate to product details or edit page
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: product['image'] != null && product['image'].isNotEmpty
                            ? ClipRRect(
                                borderRadius : BorderRadius.circular(8.0),
                                child: Image.network(
                                  product['image'],
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return Icon(Icons.error);
                                  },
                                ),
                              ):Placeholder(),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['product_name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    product['description'],
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    '\$${product['price']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16.0),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditProductPage(product['id'])),
                                );
                                print('Edit Product: ${product['product_name']}');
                                // Implement edit functionality
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _showDeleteConfirmationDialog(product['id']);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
