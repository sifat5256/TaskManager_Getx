import 'dart:convert';

import 'package:apps/data_network_coller/model_api/usermodel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authcontroller extends GetxController{
 static String ? token;
  Data ?user;
  Future<void> saveuserinformation(String t,Data model)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.setString("token",t);
    await sharedPreferences.setString("user",jsonEncode( model.toJson()));
    token=t;
    user=model;
    update();
  }

   Future<void> upgradeinformation(Data model)async{
   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
   await sharedPreferences.setString("user",jsonEncode( model.toJson()));
   user=model;
   update();
 }


 Future<void>initializeduser()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
   token= sharedPreferences.getString("token");
   user= Data.fromJson(jsonDecode(sharedPreferences.getString("user")??"{}"));
   update();
}

 Future<bool>cheekAuth()async{
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  String? token= sharedPreferences.getString("token");
  if(token!=null){
    await initializeduser();
    return true;
  }
  else{
    return false;
  }
}
 static Future<void> clearAuth()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.clear();

}

  Future<void>writeEmailverified()async{
   SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
  await sharedPreferences.getString("email");
}


}