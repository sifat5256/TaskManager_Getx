import 'package:get/get.dart';

import '../data_network_coller/data_utility/urls.dart';
import '../data_network_coller/network_coller.dart';
import '../data_network_coller/network_responce.dart';

class Resetpasscontrollerp extends GetxController{
  bool _loginprogress =false;
String _textreset="";
bool get loginprogress=>_loginprogress;
String get textreset=>_textreset;
  Future<bool> Resetpass(String email,String password, String otp) async {

    _loginprogress = true;
   update();
    Networkresponce responce = await Networkcoller().Postrequest(
        Urls.Resetpassword,
        body:{
          "email":email,
          "OTP":otp,
          "password":password,
        }
    );


    print(Urls.Resetpassword);
    print(email);
    print(otp);
    print(password);

    _loginprogress = false;

    if (responce.isSuccess) {

        _textreset= "pass success";
        return true;
      }

    else {

        _textreset= "pass failed";
        return false;


    }
  }

}