import 'package:absensi_flutter/app/modules/home/views/auth_view.dart';
import 'package:absensi_flutter/app/modules/home/views/history_view.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: '/auth',
      page: () => AuthView(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/history',
      page: () => HistoryView(),
      // binding: HomeBinding(),
    ),
  ];
}
