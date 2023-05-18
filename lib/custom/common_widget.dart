import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';

class CommonWidget {
  static InkWell social_button({
    String text,
    Gradient gradient,
    String icon,
    double width = 36,
    double height = 36,
    double radius = 12,
    // Color color = const Color.fromRGBO(255, 255, 255, 0.0),
    Color color,
    Function onpressed,
    double opacity = 1.0,
  }) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color != null ? color.withOpacity(opacity) : null,
          gradient: color == null ? gradient : null,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Center(
            child: IconButton(
          icon: Image.asset(
            'assets/icon/${icon}',
            width: 16,
            height: 16,
          ),
          // color: MyTheme.white,
        )
            // child: icon,
            ),
      ),
    );
  }

  // custom input field combined

  static Widget custom_search_widget(context, {var local_text}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            local_text ?? "",
            style: Styles.bold_app_accent_14,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: DeviceInfo(context).width,
            child: TextFormField(
              decoration: InputStyle.inputDecoration_text_field(),
            ),
          ),
        ],
      ),
    );
  }

  static Widget common_white_back(
      {context, var localization_text, Color color}) {
    return Container(
      height: 36.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: Text(
            // AppLocalizations.of(context).home_screen_full_profile,
            localization_text,
            style: Styles.regular_white_12,
          ),
        ),
      ),
    );
  }

  static Widget common_remaining_box(
      {var context, var localization_text, var value}) {
    return Container(
      width: DeviceInfo(context).width * .25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            localization_text,
            style: Styles.regular_white_12,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            value.toString(),
            style: Styles.medium_white_22,
            // textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static Widget manage_profile_update_box({context, text}) {
    return Container(
      height: 45,
      width: DeviceInfo(context).width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: [
            MyTheme.gradient_color_1,
            MyTheme.gradient_color_2,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(6.0),
        ),
      ),
      child: Center(
        child: Text(
          AppLocalizations.of(context).save_change_btn_text,
          style: Styles.bold_white_14,
        ),
      ),
    );
  }

  static Widget custom_drop_down({context, value, items, hint}) {
    return Container(
      height: 50,
      child: DropdownButtonFormField<DropDownModel>(
        iconSize: 0.0,
        decoration: InputStyle.inputDecoration_text_field(
            hint: hint, suffixIcon: Icon(Icons.keyboard_arrow_down)),
        value: value,
        items: items.map<DropdownMenuItem<DropDownModel>>((e) {
          return DropdownMenuItem<DropDownModel>(
            value: e,
            child: Text(
              e.name,
              style: Styles.regular_gull_grey_12,
            ),
          );
        }).toList(),
        onChanged: (DropDownModel newValue) {
          value = newValue;

          return value;
        },
      ),
    );
  }

  DropdownButtonFormField<DDown> buildDropdownButtonFormField(
      List<DDown> list, dynamic f,
      {dynamic value}) {
    return DropdownButtonFormField<DDown>(
      value: value,
      isExpanded: true,
      iconSize: 0.0,
      decoration: InputDecoration(
        hintText: "Select one",
        isDense: true,
        hintStyle: Styles.regular_gull_grey_12,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        suffixIcon: Icon(
          Icons.keyboard_arrow_down,
          color: MyTheme.gull_grey,
        ),
      ),
      items: list.map<DropdownMenuItem<DDown>>((e) {
        return DropdownMenuItem<DDown>(
          value: e,
          child: Text(
            e.name,
            style: Styles.regular_gull_grey_12.copyWith(color: MyTheme.black),
          ),
        );
      }).toList(),
      onChanged: (DDown newValue) {
        f(newValue);
      },
    );
  }

  DropdownButtonFormField<DDown> buildCommonDropDown(
      List<DDown> list, DDown value, dynamic onchange) {
    return DropdownButtonFormField<DDown>(
      value: value,
      isExpanded: true,
      iconSize: 0.0,
      decoration: InputDecoration(
        hintText: "Select one",
        isDense: true,
        hintStyle: Styles.regular_gull_grey_12,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        suffixIcon: Icon(
          Icons.keyboard_arrow_down,
          color: MyTheme.gull_grey,
        ),
      ),
      items: list.map<DropdownMenuItem<DDown>>((e) {
        return DropdownMenuItem<DDown>(
          value: e,
          child: Text(
            e.name,
            style: Styles.regular_gull_grey_12.copyWith(color: MyTheme.black),
          ),
        );
      }).toList(),
      onChanged: (DDown newValue) {
        onchange(newValue);
      },
    );
  }

  static BoxShadow box_shadow() {
    return BoxShadow(
      color: Colors.white,
      spreadRadius: 2,
      blurRadius: 10,
      offset: Offset(0, 5.0), // changes position of shadow
    );
  }

  static Widget noData = Center(
    child: Text(AppLocalizations.of(OneContext().context).common_no_data),
  );

  static Widget circularIndicator = Center(
    child: CircularProgressIndicator(
      color: MyTheme.storm_grey,
    ),
  );
}
