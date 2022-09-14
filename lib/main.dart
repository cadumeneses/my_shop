import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/models/auth.dart';
import 'package:my_shop/models/cart.dart';
import 'package:my_shop/models/order_list.dart';
import 'package:my_shop/models/product_list.dart';
import 'package:my_shop/pages/auth_or_home_page.dart';
import 'package:my_shop/pages/cart_page.dart';
import 'package:my_shop/pages/orders_page.dart';
import 'package:my_shop/pages/product_detail_page.dart';
import 'package:my_shop/pages/product_form_page.dart';
import 'package:my_shop/pages/product_page.dart';
import 'package:my_shop/services/dio.dart';
import 'package:my_shop/services/inject.dart';
import 'package:my_shop/utils/app_routes.dart';
import 'package:my_shop/utils/custom_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  inject();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previous) {
            return ProductList(
                auth.token ?? '', auth.uid ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) =>
              OrderList(auth.token ?? '', previous?.items ?? []),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
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
                ),
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.iOS: CustomPageTransitionsBuilder(),
                TargetPlatform.android: CustomPageTransitionsBuilder(),
              },
            )),
        // home: const ProductsOverviewPage(),
        routes: {
          AppRoutes.authOrHome: (ctx) => const AuthOrHomePage(),
          AppRoutes.productDetail: (ctx) => const ProductDetailPage(),
          AppRoutes.cart: (ctx) => const CartPage(),
          AppRoutes.orders: (ctx) => const OrdersPage(),
          AppRoutes.products: (ctx) => const ProductPage(),
          AppRoutes.productForm: (ctx) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
