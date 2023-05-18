import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/support/my_support_categories_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> getSupportTicketCategoriesMiddleware() {
  return (Store<AppState> store) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/support-ticket/categories";
    var accessToken = prefs.getString(Const.accessToken);

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });

      var data = myTicketCategoriesResponseFromJson(response.body);

      store.dispatch(MyTicketCategoriesResponse(
        links: data.links,
        meta: data.meta,
        data: data.data,
      ));
    } catch (e) {
      debugPrint(e);
      return;
    }
  };
}
