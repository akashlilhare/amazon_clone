import 'dart:convert';

import 'package:amazon_clone/constatns/global_varibales.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constatns/error_handling.dart';
import '../../../constatns/utils.dart';
import '../../../providers/user_provider.dart';
import '../../../users/product.dart ';

class ProductDetailsServices {
  // void addToCart({
  //   required BuildContext context,
  //   required Product product,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //
  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse('$baseUrl/api/add-to-cart'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': userProvider.user.token,
  //       },
  //       body: jsonEncode({
  //         'id': product.id!,
  //       }),
  //     );
  //
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         User user =
  //             userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
  //         userProvider.setUserFromModel(user);
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void rateProduct({
    required BuildContext context,
    required double rating,    required Product product,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$baseUrl/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
