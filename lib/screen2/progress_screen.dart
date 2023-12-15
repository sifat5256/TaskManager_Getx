import 'package:apps/data_network_coller/model_api/newtask.dart';
import 'package:apps/data_network_coller/model_api/taskcountsummarymodel.dart';
import 'package:apps/data_network_coller/network_coller.dart';
import 'package:apps/data_network_coller/network_responce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/progress_controller.dart';
import '../data_network_coller/data_utility/urls.dart';
import '../widget/profile_summary.dart';
import '../widget/summary_card.dart';
import '../widget/task_card.dart';

class Progressscreen extends StatefulWidget {
  const Progressscreen({super.key});

  @override
  State<Progressscreen> createState() => _ProgressscreenState();
}

class _ProgressscreenState extends State<Progressscreen> {
  Progresscoltroller _progresscoltroller=Get.find<Progresscoltroller>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progresscoltroller.countinprosummary();
    _progresscoltroller.getinprogress();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Profilesummary(),
           GetBuilder<Progresscoltroller>(
              builder:(prgress)=> Visibility(
                visible: prgress.inprogresssummary == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: prgress.taskcountsummarymodel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        Taskcount taskcount = prgress.taskcountsummarymodel.data![index];
                        return Summarycard(
                            count: taskcount.sum.toString(),
                            summary:
                                prgress.taskcountsummarymodel.data![index].id.toString());
                      }),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<Progresscoltroller>(
                builder: (progresscontroller) => Visibility(
                  visible: progresscontroller.inprogress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: () => progresscontroller.getinprogress(),
                    child: ListView.builder(
                        itemCount: progresscontroller.newtask.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Taskcard(
                            task: progresscontroller.newtask.data![index],
                            onstatuschange: () {
                              progresscontroller.getinprogress();
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
