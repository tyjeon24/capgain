import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'first_filter.dart';

class CapitalGainsParameter extends GetxController {
  var param = {}.obs;
  var firstFilteredList = [];

  void setParam(key, value) {
    param[key] = value;
  }
}
