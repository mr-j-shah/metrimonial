import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class DatePicker {
  static date_picker({hint, controller}) {
    return Theme(
      data: ThemeData(primarySwatch: MaterialColor(MyTheme.app_accent_color.value,
          <int, Color>{
            50: Color(0xFFFFEBEE),
            100: Color(0xFFFFCDD2),
            200: Color(0xFFEF9A9A),
            300: Color(0xFFE57373),
            400: Color(0xFFEF5350),
            500: Color(MyTheme.app_accent_color.value),
            600: Color(0xFFE53935),
            700: Color(0xFFD32F2F),
            800: Color(0xFFC62828),
            900: Color(0xFFB71C1C),
          })),
      child: DateTimePicker(
        controller: controller,
        decoration: InputStyle.inputDecoration_text_field(
            hint: hint,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              color: MyTheme.app_accent_color,
            )),
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
        dateLabelText: 'Date',
        onChanged: (val) {
          return controller;
        },



        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Please enter date';
          }
          return null;
        },
      ),
    );
  }
}
