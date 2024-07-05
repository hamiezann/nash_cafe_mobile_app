import 'package:flutter/foundation.dart';

class Order {
  final int id;
  final int userId; // Assuming you have userId directly in Order
  final String orderStatus;
  final double totalAmount;
  final String orderAddress;
  final DateTime createdAt;
  final List<OrderProduct> orderProducts;
  final Payment payment;
  final User user; // Add user property here

  Order({
    required this.id,
    required this.userId,
    required this.orderStatus,
    required this.totalAmount,
    required this.orderAddress,
    required this.createdAt,
    required this.orderProducts,
    required this.payment,
    required this.user,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      orderStatus: json['order_status'],
      totalAmount: double.parse(json['total_amount']),
      orderAddress: json['order_address'],
      createdAt: DateTime.parse(json['created_at']),
      orderProducts: (json['order_products'] as List)
          .map((product) => OrderProduct.fromJson(product))
          .toList(),
      payment: Payment.fromJson(json['payment']),
      user: User.fromJson(json['user']), // Parse user object here
    );
  }
}

class User {
  final int id;
  final String username;
  final String email;
  final String role;
  final String address;
  final String contactNumber;
  final DateTime emailVerifiedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.address,
    required this.contactNumber,
    required this.emailVerifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      address: json['address'],
      contactNumber: json['contact_number'],
      emailVerifiedAt: DateTime.parse(json['email_verified_at']),
    );
  }
}

class OrderProduct {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final double price;
  final Product product; // Assuming Product model is defined similarly

  OrderProduct({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.product,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      price: double.parse(json['price']),
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final int id;
  final int categoryId;
  final String description;
  final double price;
  final String image;
  final double rating;
  final String productName;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.categoryId,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.productName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['category_id'],
      description: json['description'],
      price: double.parse(json['price']),
      image: json['image'],
      rating: double.parse(json['rating']),
      productName: json['product_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Payment {
  final int id;
  final double totalPrice;
  final String paymentMethod;
  final int transactionId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Payment({
    required this.id,
    required this.totalPrice,
    required this.paymentMethod,
    required this.transactionId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      totalPrice: double.parse(json['total_price']),
      paymentMethod: json['payment_method'],
      transactionId: json['transaction_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
