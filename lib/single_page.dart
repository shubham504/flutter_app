import 'package:http/http.dart' as http;// single_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_www/item.dart'; // Adjust the path according to your project structure
import 'package:flutter_www/main.dart';
import 'dart:convert';

// import 'package:flutter/material.dart';


class SinglePage extends StatefulWidget {
  final product;

  SinglePage({required this.product});

  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
    var product_detail;

    void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products/'+widget.product['id'])); // Convert string to Uri
    if (response.statusCode == 200) {
    print(response);
      setState(() {
        product_detail = json.decode(response.body);
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
        title: Text(widget.product['title']),
      ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display thumbnail image
                  Image.network(
                    widget.product['thumbnail'],
                    height: 150, // Adjust the height as needed
                    width: double.infinity, // Take the full width of the screen
                    fit: BoxFit.cover, // Ensure the image covers the entire space
                  ),
                  SizedBox(height: 16),
            Text('Description: ${widget.product['description']}'),
            SizedBox(height: 8),
            Text('Price: \$${widget.product['price']}'),
            SizedBox(height: 8),
            
            Text('Images:'),
            for (var imageUrl in widget.product['images']) 
              Image.network(imageUrl),
            
          ],
        ),
      ),
    );
  }
}
