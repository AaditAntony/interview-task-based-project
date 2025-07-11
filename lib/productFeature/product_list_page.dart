import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trends/orderHistory/order_history_page.dart';
import 'package:trends/paymentFeatures/product_detailed_page.dart';

import 'package:trends/productFeature/error_screen.dart';

import 'product_view_model.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: productState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorScreen(
          message: err.toString(),
          onRetry: () => ref.read(productProvider.notifier).fetchProducts(),
        ),
        data: (products) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.network(product.image, height: 50, width: 50),
                  title: Text(product.title),
                  subtitle: Text("₹${product.price.toStringAsFixed(2)}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailedPage(product: product),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const OrderHistoryPage()),
          );
        },
        child: const Icon(Icons.history),
      ),
    );
  }
}
