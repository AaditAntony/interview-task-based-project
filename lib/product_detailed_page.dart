import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:trends/order_success_page.dart';
import 'package:trends/payment_failure_page.dart';
import 'product_model.dart';

class ProductDetailedPage extends StatefulWidget {
  final Product product;
  const ProductDetailedPage({super.key, required this.product});

  @override
  State<ProductDetailedPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailedPage> {
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

  void _handleSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Successful! ID: ${response.paymentId}")),
    );
    //i have implemented moving to the order success page if the payment processed correctly
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
    // i have implemented the payment failure if the payment goes wrong
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
      'key': 'rzp_test_1DP5mmOlF5G5ag', // test key from Razorpay docs
      'amount': (widget.product.price * 100).toInt(), // convert ₹ to paisa
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
    _razorpay.clear(); // clear listeners
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
