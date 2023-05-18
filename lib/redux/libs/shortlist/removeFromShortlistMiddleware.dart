import 'dart:convert';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_action.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/shortlist/remove_from_shortlist_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> removeFromShortlistMiddleware({context, dynamic user}) {
  return (Store<AppState> store) async {

    store.dispatch(DeleteShortlist());
    var baseUrl = "${AppConfig.BASE_URL}/member/remove-from-shortlist";
    var accessToken = prefs.getString(Const.accessToken);




    var postBody = jsonEncode({"user_id": user.userId});
    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = removeFromShortlistResponseFromJson(response.body);
    store.dispatch(DeleteShortlist());
      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);


    } catch (e) {
      debugPrint('Error when delete :$e');
      return;
    }
  };
}
