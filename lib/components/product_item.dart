import 'package:flutter/material.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.product_form,
                  arguments: product,
                );
              },
              color: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {},
              color: Colors.red,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
