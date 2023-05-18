import 'dart:convert';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/physical_attr_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/physical_attributes_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/physical_attr_reducer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> physicalAttrMiddleware(
    {context,
    dynamic height,
    dynamic weight,
    dynamic eye_color,
    dynamic hair_color,
    dynamic complexion,
    dynamic body_type,
    dynamic body_art,
    dynamic blood_group,
    dynamic disability}) {
  return (Store<AppState> store) async {
    store.dispatch(PhysicalAttrLoader());
    var baseUrl = "${AppConfig.BASE_URL}/member/physical-attributes/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "height": height,
      "weight": weight,
      "eye_color": eye_color,
      "hair_color": hair_color,
      "complexion": complexion,
      "body_type": body_type,
      "body_art": body_art,
      "blood_group": blood_group,
      "disability": disability
    });

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = physicalAttrUpdateResponseFromJson(response.body);
      store.dispatch(PhysicalAttrLoader());
      store.dispatch(physicalAttributesGetMiddleware());

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(PhysicalAttrUpdateResponse(
        result: data.result,
        message: data.message,
      ));
    } catch (e) {
      debugPrint(e);
      return;
    }
  };
}
