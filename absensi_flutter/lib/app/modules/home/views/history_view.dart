import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/home_controller.dart';

class HistoryView extends GetView<HomeController> {
  HistoryView({Key? key}) : super(key: key);
  var homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "History check in/out",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black, // add custom icons also
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: homeController.listAbsensi.length,
                itemBuilder: (context, index) {
                  var absen = homeController.listAbsensi[index];
                  return ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color:
                            absen['type'] == 'in' ? Colors.green : Colors.red,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            25,
                          ),
                        ),
                      ),
                      width: 50,
                      height: 50,
                      child: Center(
                        child: Text(
                          absen['type'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      Jiffy(absen['date_check']).fromNow(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(absen['date_check']),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
