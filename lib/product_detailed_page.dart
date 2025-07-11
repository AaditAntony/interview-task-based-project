import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trends/product_model.dart';

class ProductDetailedPage extends StatelessWidget {
  final Product product;
  const ProductDetailedPage({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Center(child: Image.network(product.image, height: 300)),
              SizedBox(height: 40),
              Text(
                product.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "₹${product.price.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              SizedBox(height: 20),
              Text(product.description, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
