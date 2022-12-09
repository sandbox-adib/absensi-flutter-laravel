// import 'dart:io';

import 'dart:async';

import 'package:dio/dio.dart';
// import 'package:dio/src/form_data.dart' as formdata;
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final box = GetStorage('box');

  @override
  void onInit() {
    if (box.read('user') != null) {
      user.value = box.read('user');
    }
    super.onInit();
  }

  @override
  void onReady() {
    var hourMinuteNow = Jiffy().Hms;
    hourMinuteDisplay.value = hourMinuteNow.substring(0, 5);
    secondDisplay.value = hourMinuteNow.substring(6);
    dateDisplay.value = Jiffy().yMMMMEEEEd;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      var second = int.parse(secondDisplay.value);
      if (second == 59) {
        var hourMinuteNow = Jiffy().Hms;
        hourMinuteDisplay.value = hourMinuteNow.substring(0, 5);
        secondDisplay.value = hourMinuteNow.substring(6);
      } else {
        secondDisplay.value = (second < 9 ? '0' : '') + (second + 1).toString();
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var user = {}.obs;
  var isSignIn = true.obs;
  var hourMinuteDisplay = '00:00'.obs;
  var secondDisplay = '00'.obs;
  var dateDisplay = ''.obs;
  RxList listAbsensi = [].obs;
  var btnInLoading = false.obs;
  var btnOutLoading = false.obs;
  var btnRefreshLoading = false.obs;

  var nameInput = TextEditingController();
  var emailInput = TextEditingController();
  var passwordInput = TextEditingController();

  Dio dio = Dio();
  String apiUrl = 'https://4724-115-178-248-107.ap.ngrok.io/api/test';
  String formatDate(DateTime date) =>
      DateFormat("y-MM-dd HH:mm:ss").format(date);

  absentIn() async {
    btnInLoading.value = true;
    Map<String, dynamic> data = {
      'type': 'in',
      'name': user['name'],
      'date_check': formatDate(DateTime.now())
    };
    await newAbsen(data);
    btnInLoading.value = false;
  }

  absentOut() async {
    btnOutLoading.value = true;
    Map<String, dynamic> data = {
      'type': 'out',
      'name': user['name'],
      'date_check': formatDate(DateTime.now())
    };
    await newAbsen(data);
    btnOutLoading.value = false;
  }

  Future newAbsen(data) async {
    try {
      var response = await dio.post(apiUrl + '/absen',
          data: FormData.fromMap(data),
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
            },
          ));
      var absen = response.data['data'];
      print('absen');
      print(absen);

      if (listAbsensi.value.length == 0) {
        getListAbsen();
      } else {
        listAbsensi.insert(0, absen);
      }
      Get.snackbar(
        'Successfully new absen',
        'You check ' + absen['type'] + ' on ' + data['date_check'],
        colorText: Colors.white,
        backgroundColor: Colors.black,
        duration: const Duration(
          seconds: 5,
        ),
      );
    } on DioError catch (e) {
      var msg_errors = '';

      if (e.response == null) return;

      var data = e.response!.data;

      if (e.response!.statusCode == 400) {
        data['errors'].keys.forEach((k) {
          for (var error in data['errors'][k]) {
            msg_errors += k + ' ' + error + '\n';
          }
        });
      } else {
        for (var error in data['errors']) {
          msg_errors += error + '\n';
        }
      }

      Get.snackbar(
        data['message'],
        msg_errors,
        colorText: Colors.white,
        backgroundColor: Colors.black,
        duration: const Duration(
          seconds: 3,
        ),
      );
    }
  }

  refreshListAbsen() async {
    btnRefreshLoading.value = true;
    await getListAbsen();
    btnRefreshLoading.value = false;
  }

  Future getListAbsen() async {
    print('getlist');
    try {
      var name = box.read('user')['name'];
      var absens = await dio.get(apiUrl + '/absen?name=' + name);

      listAbsensi.value = absens.data['data']['data'];
    } on DioError catch (e) {
      var data = e.response!.data;
      var msg_errors = '';

      if (e.response!.statusCode == 400) {
        data['errors'].keys.forEach((k) {
          for (var error in data['errors'][k]) {
            msg_errors += k + ' ' + error + '\n';
          }
        });
      } else {
        for (var error in data['errors']) {
          msg_errors += error + '\n';
        }
      }

      Get.snackbar(
        data['message'],
        msg_errors,
        colorText: Colors.white,
        backgroundColor: Colors.black,
        duration: const Duration(
          seconds: 3,
        ),
      );
    }
  }

  Future auth() async {
    print('asdf');
    Map<String, dynamic> data = {
      'email': emailInput.text,
      'password': passwordInput.text,
    };

    if (!isSignIn.value) data['name'] = nameInput.text;

    var url = apiUrl + '/auth/' + (isSignIn.value ? 'login' : 'register');
    try {
      var response = await dio.post(url, data: data);

      box.write('user', response.data['data']);
      user.value = response.data['data'];
      Get.snackbar(
        'Successfully ' + (isSignIn.value ? 'login' : 'register'),
        'Will be redirect to home',
        colorText: Colors.white,
        backgroundColor: Colors.black,
        duration: const Duration(
          seconds: 3,
        ),
      );
      Future.delayed(const Duration(seconds: 3), () {
        Get.toNamed('/home');
      });
    } on DioError catch (e) {
      var data = e.response!.data;
      var msg_errors = '';

      if (e.response!.statusCode == 400) {
        data['errors'].keys.forEach((k) {
          for (var error in data['errors'][k]) {
            msg_errors += k + ' ' + error + '\n';
          }
        });
      } else {
        for (var error in data['errors']) {
          msg_errors += error + '\n';
        }
      }

      Get.snackbar(
        data['message'],
        msg_errors,
        colorText: Colors.white,
        backgroundColor: Colors.black,
        duration: const Duration(
          seconds: 3,
        ),
      );
    }
  }

  logout() {
    Get.toNamed('/auth');
    box.remove('user');
  }

  test() {}
}
