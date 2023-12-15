
import 'dart:convert';

import 'package:apps/controller/auth_controller.dart';
import 'package:apps/screen/login_screen.dart';
import 'package:apps/screen2/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profilesummary extends StatelessWidget {
  Profilesummary({super.key,  this.enabletap=true});
  final bool enabletap;

  Authcontroller authcontroller=Get.find<Authcontroller>();
  @override
  Widget build(BuildContext context) {

    Uint8List imageByte =Base64Decoder().convert(authcontroller.user?.photo??"");
    return  GetBuilder<Authcontroller>(
      builder: (authcontroller)=>

        ListTile(

        onTap: (){
          if(enabletap) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Editprofilescreen();
            }));
          }},
        leading: CircleAvatar(
          child: authcontroller.user?.photo==null? Icon(Icons.person):
          Image.memory(imageByte),
        ),
        title: Text(fullname(authcontroller)),
        subtitle: Text(authcontroller.user?.email??''),
        trailing: IconButton(
          onPressed: ()async{
            await Authcontroller.clearAuth();
            Get.offAll(Loginscreen());

          }, icon:Icon( Icons.logout),
        ),
        tileColor: Colors.green,
      )

    );
  }
  String  fullname (Authcontroller authcontroller){
return ("${authcontroller.user?.firstName??""} ${authcontroller.user?.lastName??""}");
  }
}
