import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trends/order_view_model.dart';

class OrderHistoryPage extends ConsumerWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: orders.isEmpty
          ? const Center(child: Text("No orders yet."))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text(order.productName),
                  subtitle: Text("₹${order.price.toStringAsFixed(2)}"),
                  leading: const Icon(Icons.shopping_cart),
                );
              },
            ),
    );
  }
}
