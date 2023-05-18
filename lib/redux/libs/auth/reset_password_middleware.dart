import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/auth/resetpassword_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/reset_password_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> resetPasswordMiddleware(ctx,
    {@required password, @required confirm_password}) {
  return (Store<AppState> store) async {
    store.dispatch(RpLoader());

    var baseUrl = "${AppConfig.BASE_URL}/reset/password";



    var postBody = jsonEncode({
      "send_code_by": prefs.getString("reset_send_by"),
      "email_or_phone": prefs.getString("reset_email"),
      "verification_code": prefs.getString("reset_verification_code"),
      "password": password,
      "password_confirmation": confirm_password
    });

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
          body: postBody);

      var data = resetPasswordResponseFromJson(response.body);
      store.dispatch(RpLoader());

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(ResetPasswordResponse(
        result: data.result,
        message: data.message,
      ));

      if (data.result == true) {
        Navigator.pushReplacement(
          ctx,
          MaterialPageRoute(builder: (context) =>   Login()),
        );
      }
    }
    catch (e) {
      debugPrint(e);
      return;
    }
  };
}
