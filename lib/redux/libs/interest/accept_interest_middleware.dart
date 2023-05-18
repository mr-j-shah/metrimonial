import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/interest/accept_interest_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/interest_request_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/interest_request_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/interest_request_reducer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> acceptInterestMiddleware({ctx, userId}) {
  return (Store<AppState> store) async {

    store.dispatch(AcceptRejectActions.accept);
    var baseUrl = "${AppConfig.BASE_URL}/member/interest-accept";
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

      var data = acceptInterestResponseFromJson(response.body);
      store.dispatch(AcceptRejectActions.accept);



      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(interestRequestMiddleware());


      store.dispatch(
          AcceptInterestResponse(result: data.result, message: data.message));

    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}
