import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/utils/constants.dart';

import '../services/dio.dart';
import '../services/inject.dart';

class ProductList with ChangeNotifier {
  var dio = getIt.get<DioClient>();
  final String _token;
  final String _uid;

  List<Product> _items = [];

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  ProductList([
    this._token = '',
    this._uid = '',
    this._items = const [],
  ]);

  Future<void> loadProducts() async {
    _items.clear();
    try {
      final response = await dio.dio.get('products.json?auth=$_token');

      // final favoriteResponse = await dio.dio.get(
      //   ('${Constants.userFavoriteUrl}/$_uid.json?auth=$_token'),
      // );

      // Map<String, dynamic> favData =
      //     favoriteResponse.data == 'null' ? {} : jsonDecode(favoriteResponse.data);

      Map<String, dynamic> data = response.data;

      data.forEach((productId, productData) {
        // final isFavorite = favData[productId] ?? false;
        _items.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            imageUrl: productData['imageUrl'],
            price: productData['price'],
            // isFavorite: isFavorite,
          ),
        );
        notifyListeners();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['title'] as String,
      price: data['price'] as double,
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await dio.dio.post(
      ('${Constants.productBaseUrl}.json?auth=$_token'),
      data: {
        "title": product.title,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
      },
    );

    final id = response.data['name'];
    _items.add(Product(
      id: id,
      title: product.title,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      await dio.dio.patch(
        '${Constants.productBaseUrl}/${product.id}.json?auth=$_token',
        data: {
          "title": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        },
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      await dio.dio.delete(
          '${Constants.productBaseUrl}/${product.id}.json?auth=$_token');
    }
    _items.remove(product);
    notifyListeners();
  }
}
