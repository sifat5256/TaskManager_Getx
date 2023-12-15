import 'package:apps/controller/auth_controller.dart';
import 'package:apps/data_network_coller/data_utility/urls.dart';
import 'package:apps/data_network_coller/model_api/usermodel.dart';
import 'package:apps/data_network_coller/network_coller.dart';
import 'package:apps/data_network_coller/network_responce.dart';
import 'package:apps/screen/pinverification.dart';
import 'package:apps/widget/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/forgetcontroller.dart';
import '../data_network_coller/model_api/newtask.dart';
import '../widget/snack_messege.dart';
import 'login_screen.dart';
class Forgotpasswordscreen extends StatefulWidget {
  Forgotpasswordscreen({super.key});
  @override
  State<Forgotpasswordscreen> createState() => _ForgotpasswordscreenState();
}
class _ForgotpasswordscreenState extends State<Forgotpasswordscreen> {
  final TextEditingController _emailtext = TextEditingController();
  bool getemail = false;

  Forgercontroller _forgercontroller = Get.find<Forgercontroller>();
  Future<void> getemailotp() async {
    final responce = await _forgercontroller.getemailotp(_emailtext.text);
    print(Urls.emailotp(_emailtext.text));
    if (responce) {
     // await Get.find<Authcontroller>().writeEmailverified(networkresponce.jsonresponce["email"]);
      //await Get.find<Authcontroller>().writeEmailverified();
      if (mounted) {

        SnackMessege(context, _forgercontroller.forgetText);
      }
      Get.offAll( Pinverification(
            email: _emailtext.text.toString(),
      ) );

    } else {
      if (mounted) {
        SnackMessege(context, _forgercontroller.forgetText);
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
                  "Your Email adress",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text("A 6 digit OTP will be sent your email"),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailtext,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: double.infinity,
                    child: GetBuilder<Forgercontroller>(
                      builder: (forgetcontrollers) => Visibility(
                        visible: forgetcontrollers.getemail == false,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              getemailotp();
                            },
                            child: Icon(Icons.arrow_circle_right)),
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
