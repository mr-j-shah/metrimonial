import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/auth/change_password_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/change_password_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';

ThunkAction<AppState> changePasswordMiddlware({old, new_, confirm}) {
  return (Store<AppState> store) async {

    store.dispatch(CpLoader());
    var baseUrl = "${AppConfig.BASE_URL}/member/change/password";
    var accessToken = prefs.getString(Const.accessToken);

    var postBody =
    jsonEncode({"old_password": old, "password": new_, "password_confirmation": confirm});

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken"
          },
          body: postBody);

      var data = changePasswordResponseFromJson(response.body);
      store.dispatch(CpLoader());


      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);


    } catch (e) {
      print(e);
    }
  };
}
