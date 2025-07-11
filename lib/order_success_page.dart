import 'package:flutter/material.dart';

class OrderSuccessPage extends StatelessWidget {
  final String productName;
  final double price;

  const OrderSuccessPage({
    super.key,
    required this.productName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Confirmation")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 30),
              Text(
                "Your order has been placed!",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(
                productName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text("Price: ₹${price.toStringAsFixed(2)}"),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/productList',
                    (route) => false,
                  );
                },
                child: const Text("Back to Products"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
