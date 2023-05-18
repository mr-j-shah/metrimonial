import 'dart:convert';
import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/auth/signin_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_action.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/home/home_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signup_verify.dart';
import 'package:active_matrimonial_flutter_app/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:intl/intl.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:jiffy/jiffy.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:google_sign_in/google_sign_in.dart';

ThunkAction<AppState> socialLoginMiddleware(ctx,
    {email,
    name,
    provider,
    secret_token = "",
    social_provider,
    access_token = ""}) {
  return (Store<AppState> store) async {
    store.dispatch(SignInAction());

    var baseUrl = "${AppConfig.BASE_URL}/social-login";

    var postBody = jsonEncode({
      "email": email,
      "name": name,
      "provider": provider,
      "social_provider": social_provider,
      "secret_token": secret_token,
      "access_token": access_token
    });

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
          body: postBody);

      var data = signInResponseFromJson(response.body);
      store.dispatch(SignInAction());

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      if (data.message == "Please verify your account") {
        NavigatorPush.push( page: SignupVerify());
      } else if (data.message == "Please wait for admin approval") {
        NavigatorPush.push( page: Login());
      }

      if (data.result == true) {
        prefs.setBool(Const.prefIsLogin, true);
      }

      store.dispatch(SignInResponse(
          result: data.result,
          message: data.message,
          accessToken: data.accessToken,
          tokenType: data.tokenType,
          expiresAt: data.expiresAt,
          user: data.user));

      prefs.setString(Const.accessToken, data.accessToken);
      prefs.setString(Const.userName, data.user.name);
      prefs.setString(Const.userEmail,
          data.user.email == null ? data.user.phone : data.user.email);
      prefs.setString(Const.maritalStatus, data.user.maritalStatusId.name);
      prefs.setInt(
          Const.userHeight, data.user.height == '' ? 0 : data.user.height);

      prefs.setString(Const.userAge, data.user.birthday);

      store.dispatch(homeMiddleware());

      if (data.result == true) {
        Navigator.pushAndRemoveUntil(ctx, MaterialPageRoute(
          builder: (context) {
            return Main();
          },
        ), (route) => false);
      }
    } catch (e) {
      debugPrint(" error find in  ${e.toString()}");

      return;
    }
  };
}
