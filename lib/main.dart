import 'package:capgain/first_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/custom_dropdown.dart';
import 'param_controller.dart';
import 'widgets/custom_oxdropdown.dart';
import 'widgets/custom_datepicker.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 달력 한글 출력용

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final mainController = Get.put(CapitalGainsParameter());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        // 달력 한글 출력용
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        // 달력 한글 출력용
        const Locale('ko', 'KR'),
        // include country code too
      ],
      home: CapitalGainsTaxPage(),
    );
  }
}

class CapitalGainsTaxPage extends StatelessWidget {
  final controller = Get.find<CapitalGainsParameter>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ################################### 1. 기본 정보 ###############################################
              CustomDatePicker("양도예정일"),
              CustomDropdownButton(
                  baseInfo[2]["smallTitle"], baseInfo[2]["contents"]),

              Obx(() {
                if (controller.param.value[baseInfo[2]["smallTitle"]] == null) {
                  return Container();
                }

                return CustomDropdownButton(
                    baseInfo[3]["smallTitle"],
                    filtermap1[
                        controller.param.value[baseInfo[2]["smallTitle"]]]);
              }),

              CustomOXDropdownButton("상속여부"),

              Obx(() {
                if (controller.param.value[baseInfo[3]["smallTitle"]] == null) {
                  return Container();
                }

                return CustomDropdownButton(
                    baseInfo[4]["smallTitle"],
                    filtermap2[controller.param.value["양도시 종류"]]
                        [controller.param.value["취득 원인"]]);
              }),

              Obx(() {
                if (controller.param.value[baseInfo[3]["smallTitle"]] == null) {
                  return Container();
                }

                return CustomDropdownButton(
                    baseInfo[4]["smallTitle"],
                    filtermap2[controller.param.value["양도시 종류"]]
                        [controller.param.value["취득 원인"]]);
              }),

              // ################################### 2. 추가 정보 ###############################################
              // Obx(() {
              //   if (controller.param.value[baseInfo[2]["smallTitle"]] == null ||
              //       controller.param.value[baseInfo[3]["smallTitle"]] == null ||
              //       controller.param.value[baseInfo[4]["smallTitle"]] == null) {
              //     return Container();
              //   }

              //   var addtionalInfo = [];
              // }),

              // ################################### 출력 ###############################################
              Obx(
                () => Text("${controller.param.value}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BaseInfoColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> baseInfoList = [];

    for (int i = 0; i < baseInfo.length; i++) {
      if (baseInfo[i]["type"] == "date") {
        // baseInfoList.add(날짜위젯)
      } else if (baseInfo[i]["type"] == "address") {
        // baseInfoList.add(주소위젯)
      } else if (baseInfo[i]["type"] == "dropdown" &&
          baseInfo[i]["contents"].length > 0) {
        baseInfoList.add(CustomDropdownButton(
            baseInfo[i]["smallTitle"], baseInfo[i]["contents"]));
      }
    }

    return Column(children: baseInfoList);
  }
}
