import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init('box');

  final box = GetStorage('box');

  var user = box.read('user');
  // print('user');
  // print(user);
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: user == null ? '/auth' : '/home',
      getPages: AppPages.routes,
    ),
  );
}
