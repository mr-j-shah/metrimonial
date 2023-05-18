import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/auth/signin_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/auth/verify_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/vertify_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/new_password.dart';
import 'package:active_matrimonial_flutter_app/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> verifyMiddleware(ctx, {code,var fromPage}) {
  return (Store<AppState> store) async {
    store.dispatch(VLoader());

    var baseUrl = "${AppConfig.BASE_URL}/verify/code";

    var postBody = jsonEncode({"verification_code": code});

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
          body: postBody);

      var data = verifyResponseFromJson(response.body);
      store.dispatch(VLoader());

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(VerifyResponse(
        result: data.result,
        message: data.message,
      ));

      if (data.result == true) {
        Navigator.pushAndRemoveUntil(ctx, MaterialPageRoute(
          builder: (context) {
            return fromPage == "verify"? NewPassword(): Login();
          },
        ), (route) => false);
      }
    } catch (e) {
      print(e);
      return;
    }
  };
}
