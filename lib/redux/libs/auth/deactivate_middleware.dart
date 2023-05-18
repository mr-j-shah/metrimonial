import 'dart:convert';
import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

import '../../../models_response/deactivate_response.dart';

ThunkAction<AppState> deactivateMiddleware({context, dynamic deactivate_status}) {
  return (Store<AppState> store) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/account/deactivate";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({"deacticvation_status": deactivate_status});

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = deactivateResponseFromJson(response.body);

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(
        DeactivateResponse(
          result: data.result,
          message: data.message,
        ),
      );
    } catch (e) {
      debugPrint(e);
      return;
    }
  };
}
