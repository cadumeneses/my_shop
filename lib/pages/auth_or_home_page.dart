import 'package:flutter/material.dart';
import 'package:my_shop/pages/auth_page.dart';
import 'package:my_shop/pages/products_overview_page.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuth ? const ProductsOverviewPage() : const AuthPage();
  }
}
