import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:amazon_clone/constatns/error_handling.dart';
import 'package:amazon_clone/constatns/global_varibales.dart';
import 'package:amazon_clone/constatns/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/users/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constatns/app_secrate.dart';

class AdminServices {
 Future<void> sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic(
          PrivateKey.cloudinaryCloudName, PrivateKey.cloudinaryUploadPreset);
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }
      log("image url : $imageUrls");
      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);

      log(product.toJson().toString());
      var response = await http.post(
        Uri.parse("$baseUrl/admin/add-product"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: product.toJson(),
      );

      log(response.body);
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Product Added Successfully");
            Navigator.of(context).pop();
          });
    } catch (e) {
      log(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(
      {required BuildContext context}) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      var response =
          await http.get(Uri.parse("$baseUrl/admin/get-products"), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": userProvider.user.token,
      });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              log(jsonDecode(response.body)[i].toString());
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(response.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/admin/delete-product"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: jsonEncode({"id": product.id}),
      );

      log("delete response ${response.body}");
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            onSuccess();
            showSnackBar(context, "Product deleted successfully");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
