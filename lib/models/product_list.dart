import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/exceptions/http_exceptions.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/utils/constants.dart';

class ProductList with ChangeNotifier {
  Dio dio = Dio();
  final List<Product> _items = [];

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    try {
      _items.clear();
      final response = await dio.get('${Constants.productBaseUrl}.json');
      Map<String, dynamic> data = jsonDecode(response.data);
      return data.forEach((productId, productData) {
        _items.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            imageUrl: productData['imageUrl'],
            price: productData['price'],
            isFavorite: productData['isFavorite'],
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
    final response = await dio.post(
      ('${Constants.productBaseUrl}.json'),
      data: jsonEncode(
        {
          "title": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
    );

    final id = jsonDecode(response.data)['name'];
    _items.add(Product(
      id: id,
      title: product.title,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
      isFavorite: product.isFavorite,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      await dio.patch(
        '${Constants.productBaseUrl}/${product.id}.json',
        data: jsonEncode(
          {
            "title": product.title,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response =
          await dio.delete('${Constants.productBaseUrl}/${product.id}.json');

      if (response.statusCode! >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: 'Do not is possible remove this product!',
          statusCode: response.data,
        );
      }
    }
  }
}
