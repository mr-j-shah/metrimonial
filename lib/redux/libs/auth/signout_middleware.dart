import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/auth/signout_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_action.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> signOutMiddleware(
  ctx,
) {
  return (Store<AppState> store) async {
    var baseUrl = "${AppConfig.BASE_URL}/logout";

    var accessToken = prefs.getString(Const.accessToken);

    print(accessToken);
    try {
      var response = await http.post(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });

      var data = signOutResponseFromJson(response.body);

      debugPrint(data.message);
      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(SignOutResponse(
        result: data.result,
        message: data.message,
      ));

      if (data.result == true) {
        prefs.remove("_accessToken");
        prefs.remove("isLogin");
        prefs.remove("_userName");
        prefs.remove("_userEmail");
        prefs.remove("_userImage");
        prefs.remove("_userId");
        prefs.remove("_userHeight");
        prefs.remove("_userAge");
        prefs.remove("_userMaritalStatus");
        // prefs.clear();
        
        Navigator.pushAndRemoveUntil(ctx, MaterialPageRoute(
          builder: (context) {
            return Main();
          },
        ), (route) => false);
      }
    } catch (e) {
      debugPrint(e);
      return;
    }
  };
}
