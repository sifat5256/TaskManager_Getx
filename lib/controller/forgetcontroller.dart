// import 'package:get/get.dart';
//
// import '../data_network_coller/data_utility/urls.dart';
// import '../data_network_coller/network_coller.dart';
// import '../data_network_coller/network_responce.dart';
// import '../screen/pinverification.dart';
// import 'auth_controller.dart';
//
// class Forgercontroller extends GetxController {
//   bool _getemail = false;
//   String _forgetText = '';
//
//   bool get getemail => _getemail;
//
//   String get forgetText => _forgetText;
//
//   Future<bool> getemailotp(String email) async {
//     _getemail = true;
//     update();
//     Networkresponce respone =
//         await Networkcoller().getrequest(Urls.emailotp(email));
//     print(Urls.emailotp(email));
//     _getemail = false;
//     update();
//     if (respone.isSuccess) {
//       await Get.find<Authcontroller>().writeEmailverified(networkresponce.jsonresponce["email"]);
//       //respone.jsonresponce["token"];
//       _forgetText = "OTP Send success";
//       return true;
//     } else {
//       _forgetText = "OTP Failed";
//     }
//     return false;
//   }
// }

import 'package:get/get.dart';

import '../data_network_coller/data_utility/urls.dart';
import '../data_network_coller/network_coller.dart';
import '../data_network_coller/network_responce.dart';
import '../screen/pinverification.dart';
import 'auth_controller.dart';

class Forgercontroller extends GetxController {
  bool _getemail = false;
  String _forgetText = '';

  bool get getemail => _getemail;

  String get forgetText => _forgetText;

  Future<bool> getemailotp(String email) async {
    _getemail = true;
    update();
    Networkresponce response =
    await Networkcoller().getrequest(Urls.emailotp(email));
   // print(Urls.emailotp(email));
    _getemail = false;
    update();
    if (response.isSuccess) {
      await Get.find<Authcontroller>().writeEmailverified();
      //response.jsonresponse["token"];
      _forgetText = "OTP Send success";
      return true;
    } else {
      _forgetText = "OTP Failed";
    }
    return false;
  }
}
