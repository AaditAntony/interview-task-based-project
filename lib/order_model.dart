class OrderModel {
  final String productName;
  final double price;

  OrderModel({required this.productName, required this.price});

  Map<String, dynamic> toJson() => {'productName': productName, 'price': price};

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    productName: json['productName'],
    price: (json['price'] as num).toDouble(),
  );
}
