import 'package:flutter/material.dart';

// i have implemented this screeen for handling error
class ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorScreen({Key? key, required this.message, required this.onRetry})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 18, color: Colors.redAccent),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
