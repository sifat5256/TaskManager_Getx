

import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:core';
import '../data_network_coller/data_utility/urls.dart';
import '../data_network_coller/model_api/usermodel.dart';
import '../data_network_coller/network_coller.dart';
import '../data_network_coller/network_responce.dart';
import 'auth_controller.dart';

class Editprofilecontroller extends GetxController {
  XFile? photo;
  bool _upgradeprofileinprogress = false;
String _edittext="";
String get editText=>_edittext;
  bool get upgradeprofile => _upgradeprofileinprogress;
  Authcontroller authcontroller = Get.find<Authcontroller>();
//  Authcontroller authcontroller=Get.find<Authcontroller>();
  Future<bool> getupdateprofile(String email, String firstname, String lastname,
      String mobile, String password) async {
    _upgradeprofileinprogress = true;
    update();
    String? photoInBase64;
    Map<String, dynamic> inputdata = {
      "email": email,
      "firstName": firstname,
      "lastName": lastname,
      "mobile": mobile,
      "password": "",
      "photo": ""
    };
    if (password.isNotEmpty) {
      inputdata["password"] = password;
    }
    if (photo != null) {
      List<int> imageByte = await photo!.readAsBytes();
      photoInBase64 = base64Encode(imageByte);
      inputdata["photo"] = photoInBase64;
    }

    final Networkresponce networkresponce =
        await Networkcoller().Postrequest(Urls.upgradeprofile, body: inputdata);

    _upgradeprofileinprogress = false;
    update();

    if (networkresponce.isSuccess) {
      Get.find<Authcontroller>().upgradeinformation(Data(
          email: email,
          firstName: firstname,
          lastName: lastname,
          mobile: mobile,
          photo: photoInBase64 ?? authcontroller.user?.photo));
      _edittext= "Update profile Success";
      return true;
    } else {

        _edittext= "Update profile failed";

    }
    return false;
  }
}
