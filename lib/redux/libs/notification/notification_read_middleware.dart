import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/notifications_read_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_get_middleware.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';

ThunkAction<AppState> notificationReadMiddleware() {
  return (Store<AppState> store) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/mark-all-as-read";
    var accessToken = prefs.getString(Const.accessToken);

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });

      var data = readNotificationsResponseFromJson(response.body);
      store.dispatch(notificationGetMiddleware());

      store.dispatch(ReadNotificationsResponse(
          message: data.message, result: data.result));
    } catch (e) {
      debugPrint(e);
      return;
    }
  };
}
