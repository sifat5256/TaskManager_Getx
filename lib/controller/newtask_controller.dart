import 'package:get/get.dart';

import '../data_network_coller/data_utility/urls.dart';
import '../data_network_coller/model_api/newtask.dart';
import '../data_network_coller/model_api/taskcountsummarymodel.dart';
import '../data_network_coller/network_coller.dart';
import '../data_network_coller/network_responce.dart';

class Newtaskcontroller extends GetxController {
  bool _getapi = false;
  Newtask _newtask = Newtask();

  bool get getapi => _getapi;

  Newtask get newtask => _newtask;

  Future<bool> getnewscreen() async {
    bool isSuccess = false;
    _getapi = true;
    update();
    final Networkresponce responce =
        await Networkcoller().getrequest(Urls.getnewtask);
    _getapi = false;
    if (responce.isSuccess) {
      _newtask = Newtask.fromJson(responce.jsonresponce);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
