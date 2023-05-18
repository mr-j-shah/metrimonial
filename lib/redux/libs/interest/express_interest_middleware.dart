import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/interest/express_interest_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/my_interest_action.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/my_interest_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_middleware.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> expressInterestMiddleware({dynamic user}) {
  return (Store<AppState> store) async {

    store.dispatch(ExpressInterestAction());
    var baseUrl = "${AppConfig.BASE_URL}/member/express-interest";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({"user_id": user.userId});

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = expressInterestResponseFromJson(response.body);
        store.dispatch(ExpressInterestAction());

      // if (data.result == true) {
      //   store.dispatch(shortlistMiddleware());
      // } else if (data.result == false) {
      //   store.dispatch(ExpressInterestAction());
      // }
      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);
      store.dispatch(ExpressInterestResponse(
        result: data.result,
        message: data.message,
      ));
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}
