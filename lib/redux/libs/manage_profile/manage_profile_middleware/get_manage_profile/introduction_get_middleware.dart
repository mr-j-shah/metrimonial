import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/introduction_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/introduction_reducer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';


ThunkAction<AppState> introductionGetMiddleware() {
  return (Store<AppState> store) async {
    store.dispatch(pageLoader());
    var baseUrl = "${AppConfig.BASE_URL}/member/introduction";
    var accessToken = prefs.getString(Const.accessToken);

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });

      var data = introductionGetResponseFromJson(response.body);
      store.dispatch(pageLoader());

      store.dispatch(IntroductionGetResponse(
        data: data.data,
          result: data.result
      ));
    } catch (e) {
      print("error intro get middleware ${e.toString()}");
      return;
    }
  };
}
