import 'package:get/get.dart';

import '../data_network_coller/data_utility/urls.dart';
import '../data_network_coller/model_api/newtask.dart';
import '../data_network_coller/model_api/taskcountsummarymodel.dart';
import '../data_network_coller/network_coller.dart';
import '../data_network_coller/network_responce.dart';

class Progresscoltroller extends GetxController {
  bool _inprogress = false;
  bool _inprosummary = true;

  Taskcountsummarymodel _taskcountsummarymodel = Taskcountsummarymodel();
  Newtask _newtask = Newtask();
bool get inprogresssummary=>_inprosummary;
Taskcountsummarymodel get taskcountsummarymodel=>_taskcountsummarymodel;
  bool get inprogress => _inprogress;

  Newtask get newtask => _newtask;

  Future<bool> getinprogress() async {
    bool isSuccess = false;
    _inprogress = true;
    update();
    final Networkresponce networkresponce =
        await Networkcoller().getrequest(Urls.improgressScreen);
    _inprogress = false;
    if (networkresponce.isSuccess) {
      _newtask = Newtask.fromJson(networkresponce.jsonresponce);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }


  Future<void> countinprosummary() async {
    _inprosummary = true;
    update();
    final Networkresponce networkresponce =
    await Networkcoller().getrequest(Urls.gettasksummary);
    _inprosummary = false;
    if (networkresponce.isSuccess) {
      _taskcountsummarymodel =
          Taskcountsummarymodel.fromJson(networkresponce.jsonresponce);
    }
  update();
  }
}
