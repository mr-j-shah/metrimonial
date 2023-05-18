import 'dart:convert';
import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/auth/signup_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/home_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signup_action.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signup.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signup_verify.dart';
import 'package:active_matrimonial_flutter_app/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:one_context/one_context.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class AuthRepo {
  Future<SignUpResponse> postSignUp(
      {firstName,
      lastName,
      emailOrPhone,
      emailOrPhoneText,
      onBehalf,
      gender,
      dateOfBirth,
      password,
      passwordConfirmation,
      referral}) async {
    // print(id);

    var baseUrl = "${AppConfig.BASE_URL}/signup";
    var postBody = jsonEncode({
      'first_name': firstName,
      'last_name': lastName,
      '${emailOrPhoneText}': emailOrPhone,
      'on_behalf': onBehalf,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'referral_code': referral,
    });
    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody);

    var responseBody = signUpResponseFromJson(response.body);

    return responseBody;
  }
}

ThunkAction<AppState> signupMiddleware(
    {firstName,
    lastName,
    emailOrPhone,
    emailOrPhoneText,
    onBehalf,
    gender,
    dateOfBirth,
    password,
    passwordConfirmation,
    referral}) {
  return (Store<AppState> store) async {
    var g = int.parse(gender);

    store.dispatch(SignUpAction());
    try {
      var data = await AuthRepo().postSignUp(
          firstName: firstName,
          lastName: lastName,
          emailOrPhone: emailOrPhone,
          emailOrPhoneText: emailOrPhoneText,
          onBehalf: onBehalf,
          dateOfBirth: dateOfBirth,
          password: password,
          passwordConfirmation: passwordConfirmation,
          referral: referral,
          gender: g);
      if (data.message.runtimeType == String) {
        store.dispatch(SignUpAction());

        MyScaffoldMessenger().sf_messenger(
            text: data.message,
            color: data.result == true ? MyTheme.success : MyTheme.failure);

        var pageRoute = emailOrPhone == "phone"
            ? Main()
            : store.state.featureState.feature.emailVerification
                ? SignupVerify()
                : Main();

        if (data.result == true) {
          OneContext().navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => pageRoute),
              (route) => false);
        }

        store.dispatch(SignUpResponse(
          result: data.result,
          message: data.message,
        ));

        // var pageRoute = emailOrPhone == "phone" ? Main() : SignupVerify();

      } else if (data.message.runtimeType == List) {
        store.dispatch(SignUpAction());

        MyScaffoldMessenger().sf_messenger(
            text: data.message.first,
            color: data.result == true ? MyTheme.success : MyTheme.failure);

        OneContext().navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SignUp()),
            (route) => false);
      }
    } catch (e) {
      print(' error ->$e');
      return;
    }
  };
}
