import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/contact_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/contact_reducer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> contactGetMiddleware() {
  return (Store<AppState> store) async {
    store.dispatch(Cdsave());
    var baseUrl = "${AppConfig.BASE_URL}/member/get-email";
    var accessToken = prefs.getString(Const.accessToken);

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });

      var data = contactGetResponseFromJson(response.body);
      store.dispatch(Cdsave());

      store.dispatch(ContactGetResponse(data: data.data, result: data.result));
    } catch (e) {
      print("error contact get middleware ${e.toString()}");
      return;
    }
  };
}
