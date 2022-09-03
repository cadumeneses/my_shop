import 'package:flutter/material.dart';
import 'package:my_shop/components/product_component.dart';
import 'package:my_shop/models/product_list.dart';
import 'package:provider/provider.dart';

import '../components/product_grid.dart';
import '../models/product.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My Shop')),
      ),
      body: ProductGrid(),
    );
  }
}
