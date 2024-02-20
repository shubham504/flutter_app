import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_www/main.dart';
import 'package:flutter_www/single_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NextScreen extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<NextScreen> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products')); // Convert string to Uri
    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body)['products'];
      });
    } else {
      // Handle errors
      print('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // Logout logic: Set 'isLoggedIn' to false and navigate to LoginPage
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', false);

              // Navigator.pushReplacementNamed(context, '/login'); // Replace with your login route
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );

            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Image.network(
              product['images'][0], // Assuming the first image in the list
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product['title']),
            subtitle: Text(product['description']),
            trailing: Text('\$${product['price']}'),
            onTap: () {
              print(products[index]);
              // Navigate to the single page when an item is tapped
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SinglePage(product: product),
                  
                ),
              );
              
            },
            // Add more widgets as needed for other details
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NextScreen(),
  ));
}
