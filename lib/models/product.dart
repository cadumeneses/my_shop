import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.isFavorite = false,
  });

  var dio = Dio();

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String uid) async {
    try {
      _toggleFavorite();

      final response = await dio.put(
        ('${Constants.userFavoriteUrl}/$uid/$id?auth=$token'),
        data: isFavorite,
      );

      if (response.statusCode! >= 400) {
        _toggleFavorite();
      }
    } catch (_) {
      _toggleFavorite();
    }
  }
}
