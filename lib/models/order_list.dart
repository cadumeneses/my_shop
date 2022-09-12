import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/models/cart_item.dart';
import 'package:my_shop/models/order.dart';

import '../utils/constants.dart';
import 'cart.dart';

class OrderList with ChangeNotifier {
  var dio = Dio();
  final String _token;

  List<Order> _items = [];

  OrderList(this._token, this._items);
  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    List<Order> items = [];
    final response =
        await dio.get('${Constants.orderBaseUrl}.json?auth=$_token');
    Map<String, dynamic> data = response.data;
    data.forEach((orderId, orderData) {
      items.add(
        Order(
          id: orderId,
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((e) {
            return CartItem(
              id: e['id'],
              price: e['price'],
              productId: e['productId'],
              quantity: e['quantity'],
              title: e['title'],
            );
          }).toList(),
          date: DateTime.parse(orderData['date']),
        ),
      );
      _items = items.reversed.toList();
      notifyListeners();
    });
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await dio.post(
      ('${Constants.orderBaseUrl}.json?auth=$_token'),
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
