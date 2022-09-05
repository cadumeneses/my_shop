import 'package:flutter/material.dart';
import 'package:my_shop/components/app_drawer.dart';
import 'package:my_shop/components/order.dart';
import 'package:my_shop/models/order_list.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, index) => OrderWidget(order: orders.items[index]),
      ),
    );
  }
}
