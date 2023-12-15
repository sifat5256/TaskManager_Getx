import 'package:apps/main.dart';

import '../data_network_coller/data_utility/urls.dart';
import '../data_network_coller/model_api/usermodel.dart';
import '../data_network_coller/network_coller.dart';
import '../data_network_coller/network_responce.dart';
import 'auth_controller.dart';
import 'package:get/get.dart';

class Logincontroller extends GetxController {
  bool _loginprogress = false;
  String _loginMessage = "";

  bool get loginprogress => _loginprogress;

  String get loginMassage => _loginMessage;

  Future<bool> login(String email, String password) async {
    _loginprogress = true;
    update();
    Networkresponce responce = await Networkcoller().Postrequest(Urls.login,
        body: {
          "email": email,
          "password": password,
        },
        islogin: true);
    _loginprogress = false;
    update();

    if (responce.isSuccess) {
      await Get.find<Authcontroller>().saveuserinformation(
          responce.jsonresponce["token"],
          Data.fromJson(responce.jsonresponce["data"]));
      return true;
    } else {
      if (responce.statuscode == 401) {
        _loginMessage = "please cheek email/password";
      } else {
        _loginMessage = "Login failed please try again";
      }
    }
    return false;
  }
}
