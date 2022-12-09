import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/home_controller.dart';

class AuthView extends GetView<HomeController> {
  AuthView({Key? key}) : super(key: key);
  var homeC = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  homeC.isSignIn.value ? 'Welcome Back 👋' : 'Welcome 👋',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Obx(
                () => Text(
                  homeC.isSignIn.value
                      ? 'I am so happy to see You can continue to login for absent in everyday'
                      : 'I am so happy to see You can join with us for daily absent, Lets join!',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 52,
              ),
              Obx(
                () => Column(
                  children: [
                    if (!homeC.isSignIn.value) ...[
                      InputAuth(
                        text: "Name",
                        controller: homeC.nameInput,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ],
                ),
              ),
              InputAuth(
                text: "Email",
                controller: homeC.emailInput,
              ),
              const SizedBox(
                height: 24,
              ),
              InputAuth(
                text: "Password",
                controller: homeC.passwordInput,
                secureText: true,
              ),
              const SizedBox(
                height: 52,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: null,
                          backgroundColor: Colors.blue,
                          elevation: 3,
                        ),
                        onPressed: homeC.auth,
                        child: Obx(
                          () => Text(
                            homeC.isSignIn.value ? 'Login' : 'Register',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      homeC.isSignIn.value
                          ? "Don't have an account? "
                          : "Have an account ? ",
                    ),
                    InkWell(
                      onTap: () => homeC.isSignIn.value = !homeC.isSignIn.value,
                      child: Text(
                        homeC.isSignIn.value ? "Register" : "Login",
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputAuth extends StatelessWidget {
  const InputAuth({
    Key? key,
    required this.text,
    required this.controller,
    this.secureText = false,
  }) : super(key: key);

  final bool secureText;
  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        // border: InputBorder.none,
        filled: true,
        fillColor: Colors.black12,
        hintText: text,
      ),
      autofocus: false,
      obscureText: secureText,
    );
  }
}
