import 'package:apps/controller/auth_controller.dart';
import 'package:apps/controller/pinvarificationController.dart';
import 'package:apps/screen/resetpassword.dart';
import 'package:apps/widget/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../data_network_coller/data_utility/urls.dart';
import '../data_network_coller/model_api/usermodel.dart';
import '../data_network_coller/network_coller.dart';
import '../data_network_coller/network_responce.dart';
import '../widget/snack_messege.dart';
import 'login_screen.dart';

class Pinverification extends StatefulWidget {
  String email;

  Pinverification({super.key, required this.email });

  @override
  State<Pinverification> createState() => _PinverificationState();
}

class _PinverificationState extends State<Pinverification> {
  TextEditingController _getotp = TextEditingController();
  Pinvarificationcoltroller _pinvarificationcoltroller = Get.find<
      Pinvarificationcoltroller>();

  Future<void> getotpform() async {
    final responce = await _pinvarificationcoltroller.getotpform(
        _getotp.text, widget.email.toString());


    if (responce) {

        SnackMessege(context, _pinvarificationcoltroller.pintext);

Get.offAll( Resetpasswordscreen
            (email: widget.email.toString(),
            Otp: _getotp.text.toString(),));

    } else {

        SnackMessege(context, _pinvarificationcoltroller.pintext);
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
                SizedBox(height: 80,),
                Text("Pin Varification", style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,),
                SizedBox(height: 20,),
                Text("A 6 digit OTP sent your enail"),
                SizedBox(height: 48,),
                PinCodeTextField(
                  controller: _getotp,
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      activeColor: Colors.green,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.blue.shade50,
                  enableActiveFill: true,


                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    print(value);
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    return true;
                  },
                ),
                SizedBox(
                    width: double.infinity,
                    child: GetBuilder<Pinvarificationcoltroller>(
                      builder:(pinvarificontrol)=> Visibility(
                        visible: pinvarificontrol.getotp == false,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(onPressed: () {
                          getotpform(

                          );
                        }, child: Text("Verified")),
                      ),
                    )),
                SizedBox(height: 48,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account",
                      style: TextStyle(fontSize: 16, color: Colors.black54),),
                    TextButton(onPressed: () {
                     Get.offAll(Loginscreen());
                    }, child: Text("Sign in"))
                  ],
                )
              ],),
          ),
        ),
      ),
    );
  }
}

