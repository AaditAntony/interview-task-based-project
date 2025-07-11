import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'product_model.dart';

final productProvider =
    StateNotifierProvider<ProductViewModel, AsyncValue<List<Product>>>(
      (ref) => ProductViewModel(),
    );

class ProductViewModel extends StateNotifier<AsyncValue<List<Product>>> {
  ProductViewModel() : super(const AsyncValue.loading()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final products = data.map((json) => Product.fromJson(json)).toList();
        state = AsyncValue.data(products);
      } else {
        state = AsyncValue.error('Failed to load products', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error('Error: $e', StackTrace.current);
    }
  }
}
