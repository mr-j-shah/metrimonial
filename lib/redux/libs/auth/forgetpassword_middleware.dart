import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/models_response/forgetpassword_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/forgetpassword_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/verify.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> forgetPasswordMiddleware(ctx, {email, send_by}) {
  return (Store<AppState> store) async {

    store.dispatch(FpLoader());
    var baseUrl = "${AppConfig.BASE_URL}/forgot/password";

    var postBody =
        jsonEncode({"send_code_by": send_by, "email_or_phone": email});

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
          body: postBody);

      var data = forgetPasswordResponseFromJson(response.body);
      store.dispatch(FpLoader());


      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(ForgetPasswordResponse(
        result: data.result,
        message: data.message,
      ));

      if (data.result == true) {
        NavigatorPush.push(page: Verify());
      }
    } catch (e) {
      print(e);
    }
  };
}
