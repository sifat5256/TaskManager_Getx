import 'dart:convert';

import 'package:apps/controller/auth_controller.dart';
import 'package:apps/data_network_coller/data_utility/urls.dart';
import 'package:apps/data_network_coller/model_api/usermodel.dart';
import 'package:apps/data_network_coller/network_coller.dart';
import 'package:apps/data_network_coller/network_responce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/editprofilr_controller.dart';
import '../widget/profile_summary.dart';
import '../widget/snack_messege.dart';

class Editprofilescreen extends StatefulWidget {
  const Editprofilescreen({super.key});

  @override
  State<Editprofilescreen> createState() => _EditprofilescreenState();
}

class _EditprofilescreenState extends State<Editprofilescreen> {
  final TextEditingController _emailtext = TextEditingController();
  final TextEditingController _fastnametext = TextEditingController();
  final TextEditingController _lastnametext = TextEditingController();
  final TextEditingController _mobiletext = TextEditingController();
  final TextEditingController _passwordtext = TextEditingController();
  // XFile? photo;
  // bool upgradeprofileinprogress = false;
   Authcontroller authcontroller = Get.find<Authcontroller>();
  Editprofilecontroller _editprofilecontroller=Get.find<Editprofilecontroller>();
  Future<void> getupdateprofile() async {
    // upgradeprofileinprogress = true;
    // if (mounted) {
    //   setState(() {});
    // }
    // String? photoInBase64;
    // Map<String, dynamic> inputdata = {
    //   "email": _emailtext.text.trim(),
    //   "firstName": _fastnametext.text.trim(),
    //   "lastName": _lastnametext.text.trim(),
    //   "mobile": _mobiletext.text.trim(),
    //   "password": "",
    //   "photo": ""
    // };
    // if (_passwordtext.text.isNotEmpty) {
    //   inputdata["password"] = _passwordtext.text;
    // }
    // if (photo != null) {
    //   List<int> imageByte = await photo!.readAsBytes();
    //   photoInBase64 = base64Encode(imageByte);
    //   inputdata["photo"] = photoInBase64;
    // }
    //
    // final Networkresponce networkresponce =
    //     await Networkcoller().Postrequest(Urls.upgradeprofile, body: inputdata);
    //
    // upgradeprofileinprogress = false;
    // if (mounted) {
    //   setState(() {});
    // }
final responce =await _editprofilecontroller.getupdateprofile(
    _emailtext.text, _fastnametext.text, _lastnametext.text,_mobiletext.text, _passwordtext.text);
    if (responce) {
      // Get.find<Authcontroller>().upgradeinformation(Data(
      //     email: _emailtext.text.trim(),
      //     firstName: _fastnametext.text.trim(),
      //     lastName: _lastnametext.text.trim(),
      //     mobile: _mobiletext.text.trim(),
      //     photo: photoInBase64 ?? authcontroller.user?.photo));
      // if (mounted) {
        SnackMessege(context, _editprofilecontroller.editText);

    } else {
      if (mounted) {
        SnackMessege(context, _editprofilecontroller.editText);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailtext.text = authcontroller.user!.email ?? "";
    _fastnametext.text = authcontroller.user!.firstName ?? "";
    _lastnametext.text = authcontroller.user!.lastName ?? "";
    _mobiletext.text = authcontroller.user!.mobile ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Profilesummary(
                enabletap: false,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Update profile",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8))),
                                alignment: Alignment.center,
                                child: Text("Photo"),
                              )),
                          Expanded(
                              flex: 3,
                              child: InkWell(
                                onTap: () async {
                                  final XFile? image = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.camera,
                                          imageQuality: 50);
                                  if (image != null) {
                                    _editprofilecontroller.photo = image;
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  }
                                },
                                child: Container(
                                  child: Visibility(
                                      visible: _editprofilecontroller.photo == null,
                                      replacement: Text(_editprofilecontroller.photo?.name ?? ""),
                                      child: Text("Select a photo")),
                                ),
                              )),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _emailtext,
                      decoration: InputDecoration(hintText: "Emai"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _fastnametext,
                      decoration: InputDecoration(
                        hintText: "First name",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _lastnametext,
                      decoration: InputDecoration(
                        hintText: "Last name",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _mobiletext,
                      decoration: InputDecoration(
                        hintText: "Mobile",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordtext,
                      decoration: InputDecoration(
                        hintText: "Password (optional)",
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: GetBuilder<Editprofilecontroller>(
                          builder:(editprofile)=> Visibility(
                            visible: editprofile.upgradeprofile == false,
                            replacement:
                                Center(child: CircularProgressIndicator()),
                            child: ElevatedButton(
                                onPressed: getupdateprofile,
                                child: Icon(Icons.arrow_circle_right_rounded)),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
