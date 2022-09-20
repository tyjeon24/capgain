import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final mainColor = 0xff80cfd5;


Widget smallTitle(String txt) {
  return Container(
    width: 140,
    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    child: Text(
      txt,
      style: const TextStyle(fontSize: 20),
    ),
  );
}
Widget CustomTextField(TextEditingController tc, String hintText,bool able) {
  return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: TextField(
          onChanged: (text){

          },
          enabled: able,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: tc,
          cursorColor: Colors.black,
          textInputAction: TextInputAction.search,
          style: const TextStyle(fontSize: 17),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black38),
            focusedBorder: _outlineInputBorder(),
            enabledBorder: _outlineInputBorder(),
            border: _outlineInputBorder(),
          ),
        ),
      )
  );
}

OutlineInputBorder _outlineInputBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(color: Color(mainColor)),
      borderRadius: const BorderRadius.all(Radius.circular(10)));
}