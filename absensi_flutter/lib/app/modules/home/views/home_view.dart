// import 'dart:html';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  var homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: const Text('Test Absensi AhliCoding.com'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome,",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Obx(
                        () => Text(
                          homeController.user['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      homeController.logout();
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    homeController.hourMinuteDisplay.value,
                    style: const TextStyle(
                      fontSize: 60,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    homeController.secondDisplay.value,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => Text(
                homeController.dateDisplay.value,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black38,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(
                  () => CheckBtn(
                    loading: homeController.btnInLoading.value,
                    title: "Check IN",
                    checkFunction: homeController.absentIn,
                  ),
                ),
                Obx(
                  () => CheckBtn(
                    loading: homeController.btnOutLoading.value,
                    title: "Check OUT",
                    checkFunction: homeController.absentOut,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(42.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      if (homeController.listAbsensi.value.length == 0)
                        homeController.getListAbsen();
                      Get.toNamed('/history');
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          padding: const EdgeInsets.all(20.0),
                          height: 75,
                          width: 75,
                          child: SvgPicture.asset(
                            'assets/icon/history.svg',
                            // width: 42,
                            // height: 42,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text("History")
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CheckBtn extends StatelessWidget {
  const CheckBtn({
    Key? key,
    required this.checkFunction,
    required this.title,
    this.loading = false,
  }) : super(key: key);

  final VoidCallback checkFunction;
  final String title;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: checkFunction,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: title == 'Check IN'
                ? [
                    Colors.green,
                    Colors.greenAccent,
                  ]
                : [
                    Colors.red,
                    Colors.redAccent,
                  ],
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              100,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: title == 'Check IN'
                  ? Colors.green.withOpacity(0.7)
                  : Colors.red.withOpacity(0.7),
              spreadRadius: 1,
              blurRadius: 50,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 200,
        width: 200,
        child: loading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: SvgPicture.asset(
                      'assets/icon/hand-touch.svg',
                      width: 50,
                      height: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
