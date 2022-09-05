import 'package:flutter/material.dart';
import 'package:my_shop/models/cart.dart';
import 'package:my_shop/models/order_list.dart';
import 'package:my_shop/models/product_list.dart';
import 'package:my_shop/pages/cart_page.dart';
import 'package:my_shop/pages/product_detail_page.dart';
import 'package:my_shop/pages/products_overview_page.dart';
import 'package:my_shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
         ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Colors.purple,
                  secondary: Colors.deepOrange,
                ),
            textTheme: ThemeData().textTheme.copyWith(
                  headline6: const TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.white,
                  ),
                )),
        home: const ProductsOverviewPage(),
        routes: {
          AppRoutes.productDetail: (ctx) => const ProductDetailPage(),
          AppRoutes.cart: (ctx) => const CartPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
