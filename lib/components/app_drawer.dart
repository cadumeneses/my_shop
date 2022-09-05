import 'package:flutter/material.dart';
import 'package:my_shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Welcome User'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shopping'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.home,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.orders,
              );
            },
          ),
        ],
      ),
    );
  }
}
