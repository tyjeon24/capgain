import 'package:flutter/material.dart';
import '../param_controller.dart';
import 'package:get/get.dart';

class CustomDropdownButton extends StatelessWidget {
  var keyValue = "";
  List? contents = [];
  CustomDropdownButton(this.keyValue, this.contents);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();
    if (contents == null) {
      return Container();
    }

    return Obx(() {
      // 외부의 Obx와 별개로 내부에서 Obx를 한번 더 호출하는 이유는 드랍다운 값 선택 시 해당 값이 드롭다운에 표기되도록 렌더링하기 위함입니다(setState() 역할)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(keyValue),
          DropdownButton(
            value: contents!.contains(controller.param.value[keyValue])
                ? controller.param.value[keyValue]
                : null,
            items: contents?.map((item) {
              return DropdownMenuItem<String>(
                  child: new Text(item), value: item);
            }).toList(),
            onChanged: (selectedValue) {
              controller.setParam(keyValue, selectedValue);
            },
          ),
        ],
      );
    });
  }
}
