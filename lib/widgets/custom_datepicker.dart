import 'package:flutter/material.dart';
import '../param_controller.dart';
import 'package:get/get.dart';

class CustomDatePicker extends StatelessWidget {
  var keyValue = "";
  CustomDatePicker(this.keyValue);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CapitalGainsParameter>();
    String example = '날짜를 입력해 주세요.';

    return Obx(() {
      print(controller.param.value);

      // 외부의 Obx와 별개로 내부에서 Obx를 한번 더 호출하는 이유는 드랍다운 값 선택 시 해당 값이 드롭다운에 표기되도록 렌더링하기 위함입니다(setState() 역할)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(keyValue),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black26
                      )
                  )
              ),
              child: Text(example),
            ),

            onTap: (){
              Future<DateTime?> future = showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1970),
                  lastDate: DateTime(2100),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(data: ThemeData.light(), child: child!);
                  });

              future.then((date) {
                controller.setParam(keyValue, date);
                example = '${date!.year}-${date!.month}-${date!.day}';
              });
            },
          ),
        ],
      );
    });
  }
}
