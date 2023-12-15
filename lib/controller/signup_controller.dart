import 'package:get/get.dart';

import '../data_network_coller/data_utility/urls.dart';
import '../data_network_coller/network_coller.dart';
import '../data_network_coller/network_responce.dart';

class Signupcontroller extends GetxController {
  bool _signupinprogress = false;

  bool get signupinprogress => _signupinprogress;
  String _signuptext = "";

  String get signuptext => _signuptext;

  Future<bool> signup(String email, String fastname, String lastname,
      String mobile, String password) async {
    _signupinprogress = true;
    update();
    final Networkresponce responce =
        await Networkcoller().Postrequest(Urls.registation, body: {
      "email": email,
      "firstName": fastname,
      "lastName": lastname,
      "mobile": mobile,
      "password": password,
      "photo": ""
    });
    _signupinprogress = false;
    update();
    if (responce.isSuccess) {
      _signuptext = 'Account has been creat';
      return true;
    } else {
      _signuptext = "Account has not creat";
      true;
    }
    return false;
  }
}
