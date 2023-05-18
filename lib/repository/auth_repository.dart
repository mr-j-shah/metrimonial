import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/models_response/auth/signin_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signup_verify.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:one_context/one_context.dart';

class AuthRepository {
  Future<SignInResponse> signIn({email, password}) async {
    var baseUrl = "${AppConfig.BASE_URL}/signin";
    var postBody = jsonEncode({
      "email_or_phone": email,
      "password": password,
      "identity_matrix": AppConfig.purshase_code
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody);
    var data;

    if (response.statusCode == 401) {
      data = jsonDecode(response.body);
      store.dispatch(SignInAction());
      store.state.featureState.feature.emailVerification
          ? OneContext()
              .navigator
              .push(MaterialPageRoute(builder: (context) => SignupVerify()))
          : OneContext()
              .navigator
              .push(MaterialPageRoute(builder: (context) => Main()));
      store.dispatch(
          ShowMessageAction(msg: data['message'], color: MyTheme.failure));
    } else {
      data = signInResponseFromJson(response.body);
    }

    return data;
  }
}
