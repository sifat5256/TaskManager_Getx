import 'package:apps/controller/pinvarificationController.dart';
import 'package:apps/controller/reset_passcontroller.dart';
import 'package:apps/screen/login_screen.dart';
import 'package:apps/screen/pinverification.dart';
import 'package:apps/widget/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../data_network_coller/data_utility/urls.dart';
import '../data_network_coller/model_api/usermodel.dart';
import '../data_network_coller/network_coller.dart';
import '../data_network_coller/network_responce.dart';
import '../widget/snack_messege.dart';
import 'main_button_nav_screen.dart';

class Resetpasswordscreen extends StatefulWidget {
  String email;
  String Otp;

  Resetpasswordscreen({super.key, required this.email, required this.Otp});

  @override
  State<Resetpasswordscreen> createState() => _ResetpasswordscreenState();
}

class _ResetpasswordscreenState extends State<Resetpasswordscreen> {
  late String controller;

  TextEditingController _controller = TextEditingController();
  TextEditingController _comftext = TextEditingController();
  Resetpasscontrollerp _resetpasscontroller = Get.find<Resetpasscontrollerp>();

  Future<void> Resetpass() async {
    final responce=await _resetpasscontroller.Resetpass(widget.email, _controller.text, widget.Otp);
    if (responce) {
      _comftext.clear();
      _controller.clear();
      if (mounted) {
        SnackMessege(context, _resetpasscontroller.textreset);
      }
      Get.offAll( Loginscreen());

    } else {
      if (mounted) {
        SnackMessege(context, "pass failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Backgroundimage(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Set Password",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text("Minimum Password length should be more the 8 letters"),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: "Password"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _comftext,
                  decoration: InputDecoration(hintText: "Confirm Password"),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: double.infinity,
                    child: GetBuilder<Resetpasscontrollerp>(
                      builder:(resetpasscontroller)=> Visibility(
                        visible: resetpasscontroller.loginprogress == false,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              Resetpass();
                            },
                            child: Text("Confirm")),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have account?",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    TextButton(
                        onPressed: () {
                           Get.offAll(Loginscreen());
                        },
                        child: Text("Sign in"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
