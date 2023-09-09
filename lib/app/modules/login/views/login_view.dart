import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:projek_get/app/controllers/auth_controller.dart';
import 'package:projek_get/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final cAuth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Login'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            new Image(image: AssetImage("assets/UNIVERSITASTEKNOKRAT.jpg")),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller.cEmail,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              controller: controller.cPass,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: ()=> Get.toNamed(Routes.RESET_PASSWORD),
                child: Text("Reset Password"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => cAuth.login(
                controller.cEmail.text,
                controller.cPass.text,
              ), 
              child: Text("Login"),
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () => cAuth.LoginGoogle(
              ), 
              child: Text("Login with Google"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum punya akun? "),
                TextButton(
                  onPressed: ()=> Get.toNamed(Routes.SIGNUP), 
                  child: Text("Daftar Disini"),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
