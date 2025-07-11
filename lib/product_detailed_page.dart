import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:trends/order_model.dart';
import 'package:trends/order_success_page.dart';
import 'package:trends/order_view_model.dart';
import 'package:trends/payment_failure_page.dart';
import 'product_model.dart';

class ProductDetailedPage extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetailedPage({super.key, required this.product});

  @override
  ConsumerState<ProductDetailedPage> createState() =>
      _ProductDetailedPageState();
}

class _ProductDetailedPageState extends ConsumerState<ProductDetailedPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    // Listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handleSuccess(PaymentSuccessResponse response) async {
    await ref
        .read(orderViewModelProvider.notifier)
        .saveOrder(
          OrderModel(
            productName: widget.product.title,
            price: widget.product.price,
          ),
        );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Successful! ID: ${response.paymentId}")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OrderSuccessPage(
          productName: widget.product.title,
          price: widget.product.price,
        ),
      ),
    );
  }

  void _handleError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed! Reason: ${response.message}")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentFailurePage(
          reason: response.message ?? "Unknown error occurred",
        ),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External Wallet: ${response.walletName}")),
    );
  }

  void _startPayment() {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': (widget.product.price * 100).toInt(),
      'name': 'Test Shop',
      'description': widget.product.title,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Payment Error: $e');
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(title: Text("Product Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(product.image, height: 200)),
            SizedBox(height: 20),
            Text(
              product.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "₹${product.price.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 20),
            Text(product.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(100, 60)),
                onPressed: _startPayment,
                child: Text("Buy Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
