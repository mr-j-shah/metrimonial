import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/interest/accept_interest_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/interest/reject_interest_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> rejectInterestMiddleware({ctx, userId}) {
  return (Store<AppState> store) async {

    var baseUrl = "${AppConfig.BASE_URL}/member/interest-reject";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({"interest_id": userId});

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = rejectInterestResponseFromJson(response.body);


      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);
      store.dispatch(
          RejectInterestResponse(result: data.result, message: data.message));
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}
