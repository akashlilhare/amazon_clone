import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloudinary_public/cloudinary_public.dart';


class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required List<File> images,
  }) {
    try{

      final cloudinary = CloudinaryPublic("dxkmfeeew","urcicjsr");
    }catch(e){

    }
  }
}
