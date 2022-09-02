import 'package:flutter/material.dart';
import 'package:my_shop/pages/product_detail_page.dart';
import 'package:my_shop/pages/products_overview_page.dart';
import 'package:my_shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.purple,
                secondary: Colors.deepOrange,
              ),
          textTheme: ThemeData().textTheme.copyWith(
                headline6: const TextStyle(
                  fontFamily: 'Lato',
                ),
              )),
      home: ProductsOverviewPage(),
      routes: {
        AppRoutes.productDetail: (ctx) => const ProductDetailPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
