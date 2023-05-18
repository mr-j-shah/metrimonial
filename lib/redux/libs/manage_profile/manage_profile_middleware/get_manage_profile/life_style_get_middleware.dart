import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/life_style_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> lifeStyleGetMiddleware() {
  return (Store<AppState> store) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/life-style";
    var accessToken = prefs.getString(Const.accessToken);

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });

      var data = lifeStyleGetResponseFromJson(response.body);

      store
          .dispatch(LifeStyleGetResponse(data: data.data, result: data.result));
    } catch (e) {
      print("error life style get middleware ${e.toString()}");
      return;
    }
  };
}
