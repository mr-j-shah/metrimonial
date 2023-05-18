import 'dart:convert';
import 'package:active_matrimonial_flutter_app/const/const.dart';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/hobbies_interest_update_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/physical_attr_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/hobbies_interest_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/hobbies_interest_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/physical_attr_reducer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> hobbiesInterestMiddleware(
    {context,
    dynamic hobbies,
    dynamic interests,
    dynamic music,
    dynamic books,
    dynamic movies,
    dynamic tv_shows,
    dynamic sports,
    dynamic fitness_activites,
    dynamic cuisines,
    dynamic dress_styles}) {
  return (Store<AppState> store) async {
    store.dispatch(HobbiesInterestLoader());
    var baseUrl = "${AppConfig.BASE_URL}/member/hobbies/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "hobbies": hobbies,
      "interests": interests,
      "music": music,
      "books": books,
      "movies": movies,
      "tv_shows": tv_shows,
      "sports": sports,
      "fitness_activities": fitness_activites,
      "cuisines": cuisines,
      "dress_styles": dress_styles
    });

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = hobbiesInterestUpdateResponseFromJson(response.body);
      store.dispatch(HobbiesInterestLoader());
      store.dispatch(hobbiesInterestGetMiddleware());

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(HobbiesInterestUpdateResponse(
        result: data.result,
        message: data.message,
      ));
    } catch (e) {
      debugPrint(e);
      return;
    }
  };
}
