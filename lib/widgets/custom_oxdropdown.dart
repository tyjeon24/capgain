import 'package:flutter/material.dart';
import '../param_controller.dart';
import 'package:get/get.dart';

class CustomOXDropdownButton extends StatelessWidget {
  var keyValue = "";
  List<Map> contents = [
    {"displayed": "O", "value": true},
    {"displayed": "X", "value": false}
  ];

  CustomOXDropdownButton(this.keyValue);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();
    return Obx(() {
      // 외부의 Obx와 별개로 내부에서 Obx를 한번 더 호출하는 이유는 드랍다운 값 선택 시 해당 값이 드롭다운에 표기되도록 렌더링하기 위함입니다(setState() 역할)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(keyValue),
          DropdownButton(
            value: controller.param.value[keyValue] == null
                ? null
                : controller.param.value[keyValue],
            items: contents.map((item) {
              return DropdownMenuItem<bool>(
                  child: new Text(item["displayed"]), value: item["value"]);
            }).toList(),
            onChanged: (selectedValue) {
              controller.setParam(keyValue, selectedValue);
            },
          )
        ],
      );
    });
  }
}
