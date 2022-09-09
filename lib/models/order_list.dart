import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/models/order.dart';

import '../utils/constants.dart';
import 'cart.dart';

class OrderList with ChangeNotifier {
  var dio = Dio();
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await dio.post(
      ('${Constants.orderBaseUrl}.json'),
      data: {
        "total": cart.totalAmount,
        "date": date.toIso8601String(),
        "products": cart.items.values
            .map(
              (item) => {
                "id": item.id,
                "productId": item.productId,
                "title": item.title,
                "quantity": item.quantity,
                "price": item.price,
              },
            )
            .toList(),
      },
    );

    final id = response.data['name'];
    _items.insert(
      0,
      Order(
        id: id,
        date: date,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}
