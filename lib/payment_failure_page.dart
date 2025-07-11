import 'package:flutter/material.dart';

class PaymentFailurePage extends StatelessWidget {
  final String reason;

  const PaymentFailurePage({super.key, required this.reason});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Failed")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cancel, color: Colors.red, size: 100),
              const SizedBox(height: 30),
              Text("Oops! Payment failed.", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Text(
                reason,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
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
