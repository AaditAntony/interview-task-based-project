import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'order_model.dart';

final orderViewModelProvider =
    StateNotifierProvider<OrderViewModel, List<OrderModel>>(
      (ref) => OrderViewModel(),
    );

class OrderViewModel extends StateNotifier<List<OrderModel>> {
  OrderViewModel() : super([]) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final storedOrders = prefs.getStringList('orders') ?? [];
    state = storedOrders
        .map((orderString) => OrderModel.fromJson(jsonDecode(orderString)))
        .toList();
  }

  Future<void> saveOrder(OrderModel order) async {
    final prefs = await SharedPreferences.getInstance();
    final existingOrders = prefs.getStringList('orders') ?? [];

    existingOrders.add(jsonEncode(order.toJson()));
    await prefs.setStringList('orders', existingOrders);

    state = [...state, order];
  }

  Future<void> clearOrders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('orders');
    state = [];
  }
}
