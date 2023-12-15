import 'package:apps/controller/newtask_controller.dart';
import 'package:apps/controller/progress_controller.dart';
import 'package:apps/data_network_coller/data_utility/urls.dart';
import 'package:apps/data_network_coller/model_api/newtask.dart';
import 'package:apps/data_network_coller/model_api/taskcountsummarymodel.dart';
import 'package:apps/data_network_coller/network_coller.dart';
import 'package:apps/data_network_coller/network_responce.dart';
import 'package:apps/widget/profile_summary.dart';
import 'package:apps/widget/summary_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/task_card.dart';

class Newscreen extends StatefulWidget {
  Newscreen({super.key});

  @override
  State<Newscreen> createState() => _NewscreenState();
}

class _NewscreenState extends State<Newscreen> {
  Newtaskcontroller _newtaskcontroller = Get.find<Newtaskcontroller>();
  Progresscoltroller _progresscoltroller = Get.find<Progresscoltroller>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progresscoltroller.countinprosummary();
    _newtaskcontroller.getnewscreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Profilesummary(),
            GetBuilder<Progresscoltroller>(
              builder: (progress) => Visibility(
                  visible: progress.inprogresssummary == false &&
                      (progress.taskcountsummarymodel.data?.isNotEmpty ??
                          false),
                  replacement: LinearProgressIndicator(),
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            progress.taskcountsummarymodel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          Taskcount taskcount =
                              progress.taskcountsummarymodel.data![index];
                          return FittedBox(
                            child: Summarycard(
                                count: taskcount.sum.toString(),
                                summary: taskcount.id.toString()),
                          );
                        }),
                  )),
            ),
            Expanded(
              child: GetBuilder<Newtaskcontroller>(
                builder: (newtaskcontroller) => Visibility(
                  visible: newtaskcontroller.getapi == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: () => newtaskcontroller.getnewscreen(),
                    child: ListView.builder(
                        itemCount: newtaskcontroller.newtask.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Taskcard(
                            task: newtaskcontroller.newtask.data![index],
                            onstatuschange: () {
                              newtaskcontroller.getnewscreen();
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
