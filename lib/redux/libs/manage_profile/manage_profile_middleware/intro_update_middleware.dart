import 'dart:convert';
import 'package:active_matrimonial_flutter_app/const/const.dart';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/introduction_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/introduction_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/introduction_reducer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> IntroUpdateMiddleware({context, dynamic text}) {
  return (Store<AppState> store) async {
    store.dispatch(IntroLoader());
    var baseUrl = "${AppConfig.BASE_URL}/member/introduction-update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({"introduction": text});

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = introductionUpdateResponseFromJson(response.body);
      store.dispatch(IntroLoader());
      store.dispatch(introductionGetMiddleware());

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(IntroductionUpdateResponse(
        result: data.result,
        message: data.message,
      ));
    } catch (e) {
      debugPrint(e);
      return;
    }
  };
}
