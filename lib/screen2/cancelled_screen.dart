import 'package:apps/controller/cancelledController.dart';
import 'package:apps/controller/progress_controller.dart';
import 'package:apps/data_network_coller/model_api/newtask.dart';
import 'package:apps/data_network_coller/model_api/taskcountsummarymodel.dart';
import 'package:apps/data_network_coller/network_coller.dart';
import 'package:apps/data_network_coller/network_responce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data_network_coller/data_utility/urls.dart';
import '../widget/profile_summary.dart';
import '../widget/summary_card.dart';
import '../widget/task_card.dart';

class Cencelledscreen extends StatefulWidget {
  const Cencelledscreen({super.key});

  @override
  State<Cencelledscreen> createState() => _CencelledscreenState();
}

class _CencelledscreenState extends State<Cencelledscreen> {
  Cencelledcontroller _cencelledcontroller = Get.find<Cencelledcontroller>();
  Progresscoltroller _progresscoltroller = Get.find<Progresscoltroller>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cencelledcontroller.getcencelled();
    _progresscoltroller.countinprosummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Profilesummary(),
            GetBuilder<Progresscoltroller>(
              builder: (progresscount) => Visibility(
                visible: progresscount.inprogresssummary == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          progresscount.taskcountsummarymodel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        Taskcount taskcoun =
                            progresscount.taskcountsummarymodel.data![index];
                        return Summarycard(
                            count: taskcoun.sum.toString(),
                            summary: progresscount
                                .taskcountsummarymodel.data![index].id
                                .toString());
                      }),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<Cencelledcontroller>(
                builder: (cencelledcontroller) => Visibility(
                  visible: cencelledcontroller.getapi == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: () => cencelledcontroller.getcencelled(),
                    child: ListView.builder(
                        itemCount:
                            cencelledcontroller.newtask.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Taskcard(
                            task: cencelledcontroller.newtask.data![index],
                            onstatuschange: () {
                              cencelledcontroller.getcencelled();
                            },
                            showprogress: (Inprogress) {},
                          );
                        }),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
