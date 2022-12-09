import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  var homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Test Absensi AhliCoding.com'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: homeController.nameInput,
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: homeController.absentIn,
                      style: TextButton.styleFrom(
                        padding: null,
                        backgroundColor: Colors.green,
                        shadowColor: Colors.black.withOpacity(1),
                        elevation: 3,
                      ),
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            homeController.btnInLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "IN",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: homeController.absentOut,
                      style: TextButton.styleFrom(
                        padding: null,
                        backgroundColor: Colors.red,
                        shadowColor: Colors.black.withOpacity(1),
                        elevation: 3,
                      ),
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            homeController.btnOutLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "OUT",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: homeController.refreshListAbsen,
                    icon: Obx(() => homeController.btnRefreshLoading.value
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.refresh)),
                  ),
                ],
              ),
              Column(
                children: [
                  Obx(
                    () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: homeController.listAbsensi.length,
                        itemBuilder: (context, index) {
                          var absen = homeController.listAbsensi[index];
                          return ListTile(
                            title: Text(
                              "Check " +
                                  absen['type'] +
                                  " " +
                                  Jiffy(absen['date_check']).fromNow(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(absen['date_check']),
                          );
                        }),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
