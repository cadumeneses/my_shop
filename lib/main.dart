import 'package:flutter/material.dart';
import 'package:my_shop/models/product_list.dart';
import 'package:my_shop/pages/counter_page.dart';
import 'package:my_shop/pages/product_detail_page.dart';
import 'package:my_shop/pages/products_overview_page.dart';
import 'package:my_shop/providers/counter.dart';
import 'package:my_shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
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
          AppRoutes.productDetail: (ctx) => const CounterPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
