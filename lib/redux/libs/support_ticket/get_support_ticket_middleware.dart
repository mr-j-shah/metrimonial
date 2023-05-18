import 'dart:convert';
import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/support/my_ticket_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket/support_ticket_reducer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> getSupportTicketMiddleware() {
  return (Store<AppState> store) async {
    store.dispatch(SupportFetch());

    var baseUrl = "${AppConfig.BASE_URL}/member/my-tickets";
    var accessToken = prefs.getString(Const.accessToken);

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      var jsonData = jsonDecode(response.body);
      if (jsonData['result'] == false) {
        store.dispatch(SupportFetch());
      } else {
        var data = myTicketResponseFromJson(response.body);
        store.dispatch(SupportFetch());
        store.dispatch(StoreTicketAction(payload: data.data));
      }
    } catch (e) {
      debugPrint(e);
      return;
    }
  };
}
