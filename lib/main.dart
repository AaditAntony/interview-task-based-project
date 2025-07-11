import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trends/orderHistory/order_history_page.dart';
import 'package:trends/productFeature/product_list_page.dart';
import 'package:trends/loginFeature/splash_page.dart';

import 'loginFeature/login_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => LoginPage(),
        '/productList': (context) => ProductListPage(),
        '/orderHistorypage': (context) => OrderHistoryPage(),
      },
    );
  }
}
