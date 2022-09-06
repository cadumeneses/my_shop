import 'package:flutter/material.dart';
import 'package:my_shop/components/app_drawer.dart';
import 'package:my_shop/components/product_item.dart';
import 'package:my_shop/models/product_list.dart';
import 'package:my_shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.product_form);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: ((context, index) => Column(
                  children: [
                    ProductItem(
                      product: products.items[index],
                    ),
                    const Divider(),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
