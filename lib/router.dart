import 'package:amazon_clone/constatns/bottom_bar.dart';
import 'package:amazon_clone/features/admin/admin_screen.dart';
import 'package:flutter/material.dart';

import 'features/admin/screens/add_product_screen.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());

    case BottomBar.routeName:
      return MaterialPageRoute(builder: (_) => const BottomBar());

      case AdminScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AdminScreen());

      case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddProductScreen());

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("route not implemented "),
                ),
              ));
  }
}
