import 'package:apps/data_network_coller/model_api/newtask.dart';
import 'package:apps/data_network_coller/model_api/taskcountsummarymodel.dart';
import 'package:apps/data_network_coller/network_coller.dart';
import 'package:apps/data_network_coller/network_responce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/compeletController.dart';
import '../controller/progress_controller.dart';
import '../data_network_coller/data_utility/urls.dart';
import '../widget/profile_summary.dart';
import '../widget/summary_card.dart';
import '../widget/task_card.dart';

class Compeletescreen extends StatefulWidget {
  const Compeletescreen({super.key});

  @override
  State<Compeletescreen> createState() => _CompeletescreenState();
}

class _CompeletescreenState extends State<Compeletescreen> {
// bool completeinpro=false;
// bool completsummarys=false;
//
// Newtask newtask =Newtask();
// Taskcountsummarymodel taskcountsummarymodel=Taskcountsummarymodel();
//
//   Future<void>getcompleted()async{
//     completeinpro=true;
//     if(mounted){
//       setState(() {
//
//       });
//     }
//     final Networkresponce networkresponce =await Networkcoller().getrequest(Urls.completedscreen);
//     if(networkresponce.isSuccess){
// newtask=Newtask.fromJson(networkresponce.jsonresponce);
//     }
//     completeinpro=false;
//     if(mounted){
//       setState(() {
//
//       });
//     }
//   }
//   Future<void>completedsummary()async{
//     completsummarys=true;
//     if(mounted){
//       setState(() {
//
//       });
//     }
//     final Networkresponce networkresponce = await Networkcoller().getrequest(Urls.gettasksummary);
//     if(networkresponce.isSuccess){
// taskcountsummarymodel=Taskcountsummarymodel.fromJson(networkresponce.jsonresponce);
//     }
//     completsummarys=false;
//     if(mounted){
//       setState(() {
//
//       });
//     }
//   }
  Compeletcontroller _compeletcontroller = Get.find<Compeletcontroller>();
  Progresscoltroller _progresscoltroller = Get.find<Progresscoltroller>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _compeletcontroller.getcompeleted();
    _progresscoltroller.countinprosummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Profilesummary(),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //
            //       Summarycard(count: "9", summary: "New"),
            //       Summarycard(count: "9", summary: "in progress"),
            //       Summarycard(count: "9", summary: "Completed"),
            //       Summarycard(count: "9", summary: "Cancelled")
            //     ],
            //   ),
            // ),
            GetBuilder<Progresscoltroller>(
              builder: (progresscontroller) => Visibility(
                visible: progresscontroller.inprogresssummary == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: progresscontroller
                              .taskcountsummarymodel.data?.length ??
                          0,
                      itemBuilder: (context, index) {
                        Taskcount taskcount = progresscontroller
                            .taskcountsummarymodel.data![index];
                        return Summarycard(
                          count: taskcount.sum.toString(),
                          summary: taskcount.id.toString(),
                        );
                      }),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<Compeletcontroller>(
                builder: (compeletcontrol) => Visibility(
                  visible: compeletcontrol.getapi == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: () => compeletcontrol.getcompeleted(),
                    child: ListView.builder(
                        itemCount: compeletcontrol.newtask.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Taskcard(
                            task: compeletcontrol.newtask.data![index],
                            onstatuschange: () {
                              compeletcontrol.getcompeleted();
                            },
                            showprogress: (Inpgroee) {},
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
