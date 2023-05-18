import 'dart:convert';
import 'package:active_matrimonial_flutter_app/const/const.dart';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/search/basic_search_response/basic_search_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/basic_info_reducer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> searchMiddleware(
    {dynamic age,
    dynamic to,
    dynamic religion,
    dynamic motherTongue,
    dynamic memberCode,
    dynamic maritalStatus,
    dynamic caste,
    dynamic subCaste,
    dynamic profession,
    dynamic country,
    dynamic state,
    dynamic city,
    dynamic minHeight,
    dynamic maxHeight,
    dynamic memberType}) {
  return (Store<AppState> store) async {
    store.dispatch(SearchLoader());
    var baseUrl = "${AppConfig.BASE_URL}/member/member-listing";
    var accessToken =  prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "age_from": age,
      "age_to": to,
      "member_code": memberCode,
      "marital_status": maritalStatus,
      "religion_id": religion,
      "caste_id": caste,
      "sub_caste_id": subCaste,
      "mother_tongue": motherTongue,
      "profession": profession,
      "country_id": country,
      "state_id": state,
      "city_id": city,
      "min_height": minHeight,
      "max_height": maxHeight,
      "member_type": memberType
    });

    try {
    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: postBody);

    var data = basicSearchResponseFromJson(response.body);
    store.dispatch(SearchLoader());

    store.dispatch(BasicSearchResponse(result: data.result, data: data.data));
    } catch (e) {
      debugPrint(e);
      return;
    }
  };
}
