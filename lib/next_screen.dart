import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
