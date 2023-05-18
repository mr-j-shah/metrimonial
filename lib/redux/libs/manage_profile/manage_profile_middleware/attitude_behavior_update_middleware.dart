import 'dart:convert';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/attitude_behaviour_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/attitude_interest_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/attitude_behavior_reducer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';

ThunkAction<AppState> attitudeBehaviorUpdateMiddleware({
  context,
  dynamic affection,
  dynamic humor,
  dynamic religious_service,
  dynamic political_views,
}) {
  return (Store<AppState> store) async {
    store.dispatch(AttitudeBehaviorLoader());

    var baseUrl = "${AppConfig.BASE_URL}/member/attitude-behavior/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "affection": affection,
      "humor": humor,
      "religious_service": religious_service,
      "political_views": political_views,
    });

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = attitudeBehaviourUpdateResponseFromJson(response.body);
      store.dispatch(AttitudeBehaviorLoader());
      store.dispatch(attitudeInterestsGetMiddleware());

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(AttitudeBehaviourUpdateResponse(
        result: data.result,
        message: data.message,
      ));
    } catch (e) {
      debugPrint(e);
      return;
    }
  };
}
