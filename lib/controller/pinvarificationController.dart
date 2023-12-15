import 'package:get/get.dart';

import '../data_network_coller/data_utility/urls.dart';
import '../data_network_coller/network_coller.dart';
import '../data_network_coller/network_responce.dart';

class Pinvarificationcoltroller extends GetxController {
  bool _getotpp = false;

  bool get getotp => _getotpp;
 String _pintext="";
 String get pintext=>_pintext;
  Future<bool> getotpform(String otp,String email) async {
    _getotpp = true;
 update();
    final Networkresponce networkresponce = await Networkcoller()
        .getrequest(Urls.otpfrom(email.toString(), otp));
    _getotpp = false;
    update();
    print(Urls.otpfrom(email.toString(), otp));


    if (networkresponce.isSuccess &&
        networkresponce.jsonresponce["status"] == "success") {
      //await Authcontroller.writeEmailverified(networkresponce.jsonresponce["email"]);

        _pintext= "OTP success";
      return true;
      //
      // if (mounted) {
      //   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return Resetpasswordscreen(
      //       email: widget.email.toString(),
      //       Otp: _getotp.text.toString(),
      //     );
      //   }));
      // }
    } else {

        _pintext= "OTP Failed";

    }
    return false;
  }
}
